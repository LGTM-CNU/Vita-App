import 'package:http/http.dart' as http;

class Fetcher {
  static const String _baseUrl = "http://localhost:4000";

  static Future fetch(method, path, body) async {
    final url = Uri.parse(_baseUrl + path);
    if (method == 'get') {
      final response = await http.get(url);
      return response;
    } else if (method == 'post') {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: body);
      return response;
    } else if (method == 'patch') {
      final response = await http.patch(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: body);
      return response;
    } else if (method == 'delete') {
      final response = await http.delete(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: body);
      return response;
    }
    return "Error";
  }
}
