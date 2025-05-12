import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intellimate/api/api_service.dart';
import 'package:intellimate/constants.dart';
import 'package:intellimate/hive/chat_history.dart';
import 'package:intellimate/hive/settings.dart';
import 'package:intellimate/hive/user_model.dart';
import 'package:intellimate/models/message.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:uuid/uuid.dart';

class ChatProvider extends ChangeNotifier {
  // List of messages
  List<Message> _inChatMessage = [];

  // Page Controller
  final PageController _pageController = PageController();

  // Images files list
  List<XFile> _imagesFileList = [];

  // Index of the current screen
  int _currentIndex = 0;

  // current chat id
  String _currentChatId = "";

  // Initialize Generative Model
  GenerativeModel? _model;

  // Initalize the Text Model
  GenerativeModel? _textModel;

  // Initialize the Visual Model
  GenerativeModel? _visualModel;

  // Current Model
  String _modelType = "gemini-pro"; // Text model is the default

  // loading bool
  bool _isLoading = false;

  // -------->  Getters  <------------- //

  List<Message> get inChatMessages => _inChatMessage;
  PageController get pageController => _pageController;
  List<XFile>? get imagesFileList => _imagesFileList;
  int get currentIndex => _currentIndex;
  String get currentChatId => _currentChatId;

  // Getting The Generative AI Models
  GenerativeModel? get model => _model; // general ai model
  GenerativeModel? get textModel => _textModel; // Text ai model
  GenerativeModel? get visualModel => _model; // Visual ai model

  String get modelType => _modelType;
  bool get isLoading => _isLoading;

  // --------->   SETTERS   <---------- //

  // set inMessages
  Future<void> setInChatMessages({required String chatId}) async {
    // Getting msgs from database(HIVE

    final messageFromDB = await loadMessageFromDB(chatId: chatId);

    for (var message in messageFromDB) {
      // If Message is already in inchat then we don't have to enter them
      if (inChatMessages.contains(message)) {
        developer.log("Message already exits");
        continue;
      }

      _inChatMessage.add(message);
    }
    // Notifying the changes
    notifyListeners();
  }

  // Load msgs from db
  Future<List<Message>> loadMessageFromDB({required String chatId}) async {
    // Open the box of this chatId
    await Hive.openBox('$Constants.chatMessagesBox$chatId');

    final messageBox = Hive.box('$Constants.chatMessagesBox)$chatId');

    // Returning the new data
    final newData =
        messageBox.keys.map((e) {
          final message = messageBox.get(e);
          final messageData = Message.fromMap(
            Map<String, dynamic>.from(message),
          );

          return messageData;
        }).toList();
    notifyListeners();
    return newData;
  }

  // Set Files list
  void setImagesFileList({required List<XFile> listValue}) {
    _imagesFileList = listValue;
    notifyListeners();
  }

  // Setting the current model
  String setCurrentModel({required String newModel}) {
    _modelType = newModel;
    notifyListeners();

    return newModel;
  }

  // Function to set model based on bool - IsTextonly
  Future<void> setModel({required bool isTextOnly}) async {
    if (isTextOnly) {
      _model =
          _textModel ??
          GenerativeModel(model: 'gemini-pro', apiKey: ApiService.api_key!);
      _textModel = _model;
    } else {
      _model =
          _visualModel ??
          GenerativeModel(
            model: 'gemini-pro-vision',
            apiKey: ApiService.api_key!,
          );
      _visualModel = _model;
    }

    notifyListeners();
  }

  // Setter for managing the page index
  void setCurrentIndex({required int newIndex}) {
    _currentIndex = newIndex;
    notifyListeners();
  }

  // Setting the current id
  void setCurrentChatId({required String newChatId}) {
    _currentChatId = newChatId;
    notifyListeners();
  }

  // Setting the loading
  void setLoading({required bool newLoading}) {
    _isLoading = newLoading;
    notifyListeners();
  }

  // --------->   SENDING REQUEST TO GEMINI AND GETTING THE RESPONSE STREAM   <---------- //

  Future<void> sentMessage({
    required String message,
    required bool isTextOnly,
  }) async {
    // Setting the model
    await setModel(isTextOnly: isTextOnly);

    // Setting the loading
    setLoading(newLoading: true);

    // We need a method
    // - If we are creating the chat for first time then we need chatid
    // - Otherwiser we don't need a chat id
    String chatId = getChatId();

    // Initializing the List of  History Messages
    List<Content> history = [];

    // Get Chat History
    history = await getHistory(chatId: chatId);

    // Get Image Urls
    List<String> imagesUrls = getImagesUrls(isTextOnly: isTextOnly);

    // User message
    final userMessage = Message(
      messageId: "",
      chatId: chatId,
      role: Role.user,
      message: StringBuffer(message), // this is a stream buffer
      imageUrls: imagesUrls,
      timeSent: DateTime.now(),
    );

    // Adding this messages into the inChatMessages
    _inChatMessage.add(userMessage);
    notifyListeners();

    if (currentChatId.isEmpty) {
      setCurrentChatId(newChatId: chatId);
    }

    // Send message to model and wait for the response
    await sendMessageAndWaitForResponse(
      message: message,
      chatId: chatId,
      isTextOnly: isTextOnly,
      history: history,
      userMessage: userMessage,
    );
  }

  // get Images url
  List<String> getImagesUrls({required bool isTextOnly}) {
    List<String> imagesUrls = [];
    if (!isTextOnly && imagesFileList != null) {
      for (var image in imagesFileList!) {
        imagesUrls.add(image.path);
      }
    }
    return imagesUrls;
  }

  // Get the histry messages
  Future<List<Content>> getHistory({required String chatId}) async {
    List<Content> history = [];

    if (currentChatId.isNotEmpty) {
      await setInChatMessages(chatId: chatId);

      for (var message in inChatMessages) {
        if (message.role == Role.user) {
          history.add(Content.text(message.message.toString()));
        } else {
          history.add(Content.model([TextPart(message.message.toString())]));
        }
      }
    }

    return history;
  }

  // Gets the unique chat it
  String getChatId() {
    if (currentChatId.isEmpty) {
      return const Uuid().v4();
    }

    return currentChatId;
  }

  // Init Hive box
  static initHive() async {
    final dir = await path.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.initFlutter(Constants.geminiDB);

    // Register Adapters //

    // ChatHistory Adapter
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ChatHistoryAdapter());

      // Open the chat history box
      await Hive.openBox<ChatHistory>(Constants.chatHistoryBox);
    }

    // Register usermodel
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserModelAdapter());

      // Open the usermodel
      await Hive.openBox<UserModel>(Constants.userBox);
    }

    // Register Settings
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(SettingsAdapter());

      // Open the usermodel
      await Hive.openBox<Settings>(Constants.settingsBox);
    }
  }
}
