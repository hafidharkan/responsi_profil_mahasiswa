import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
}
class Validators {
  static String? validateTitle(String? value) {
    if (value == null || value.length < 3 || value.length > 50) {
      return 'Judul harus 3-50 karakter';
    }
    return null;
  }

  static String? validateContent(String? value) {
    if (value == null || value.length < 10 || value.length > 1000) {
      return 'Isi catatan harus 10-1000 karakter';
    }
    return null;
  }

  static String sanitize(String input) {
    return input.replaceAll('<', '').replaceAll('>', '').replaceAll('"', '').replaceAll("'", "");
  }
}