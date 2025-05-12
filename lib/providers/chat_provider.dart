import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intellimate/constants.dart';
import 'package:intellimate/hive/chat_history.dart';
import 'package:intellimate/hive/settings.dart';
import 'package:intellimate/hive/user_model.dart';
import 'package:intellimate/models/message.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:generative_ai_dart/generative_ai_dart.dart';
import 'package:path_provider/path_provider.dart' as path;

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

  // -------------> SETTERS <--------------- //

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
