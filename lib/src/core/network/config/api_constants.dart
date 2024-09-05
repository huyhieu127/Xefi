import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static final baseUrl = '${dotenv.env['BASE_URL']}';
  static final urlImage = '${dotenv.env['URL_IMAGE']}';
  //static final apiToken = '${dotenv.env['API_TOKEN']}';
  static const limit = 20;
}
