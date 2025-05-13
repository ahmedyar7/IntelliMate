import 'package:flutter_dotenv/flutter_dotenv.dart';

class Urls {
  static const String geminiBaseUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent";
  static String? geminiApiKey = dotenv.env['GEMINI_API_KEY']; // Store securely
}

/// here we change model
/// /// change your api key also if any api key related problem message  message
