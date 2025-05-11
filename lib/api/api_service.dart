import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static var api_key = dotenv.env['GEMINI_API_KEY'];
}
