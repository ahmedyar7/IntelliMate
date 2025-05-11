import 'package:hive_flutter/hive_flutter.dart';
import 'package:intellimate/constants.dart';
import 'package:intellimate/hive/chat_history.dart';
import 'package:intellimate/hive/settings.dart';
import 'package:intellimate/hive/user_model.dart';

class Boxes {
  // This would replicate the chat history of he user and the AI Agent
  static Box<ChatHistory> getChatHistory() =>
      Hive.box<ChatHistory>(Constants.chatHistoryBox);

  // Get the user box
  static Box<UserModel> getUser() => Hive.box<UserModel>(Constants.userBox);

  // Get the settings box
  static Box<Settings> getSettings() =>
      Hive.box<Settings>(Constants.settingsBox);
}
