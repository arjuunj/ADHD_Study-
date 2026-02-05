import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  // Using a placeholder URL as discussed in the plan.
  // In a real app, this would likely be in a config or environment variable.
  static const String baseUrl = "http://127.0.0.1:8000";

  Future<String> sendMessage(String prompt, {String? subject}) async {
    final url = Uri.parse('$baseUrl/chat');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'prompt': prompt,
          if (subject != null) 'subject': subject,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data.containsKey('response')) {
          return data['response'];
        } else {
          throw Exception('Invalid response format: missing "response" key');
        }
      } else {
        throw Exception('Failed to load response: ${response.statusCode}');
      }
    } catch (e) {
      // Re-throw so the UI can handle/display the error
      throw Exception('Error sending message: $e');
    }
  }
}
