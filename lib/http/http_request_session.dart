import 'package:http/http.dart' as http;

class Session {
  Map<String, String> headers = {};

  Future<http.Response> request(String method, String url, {Map<String, String>? headers, Object? body}) async {
    final requestHeaders = {...?this.headers, ...?headers};
    final uri = Uri.parse(url);
    http.Response response;

    switch (method.toUpperCase()) {
      case 'GET':
        response = await http.get(uri, headers: requestHeaders);
        break;
      case 'POST':
        response = await http.post(uri, headers: requestHeaders, body: body);
        break;
      case 'PUT':
        response = await http.put(uri, headers: requestHeaders, body: body);
        break;
      case 'DELETE':
        response = await http.delete(uri, headers: requestHeaders);
        break;
      default:
        throw UnsupportedError('Unsupported HTTP method: $method');
    }
    
    return response;
  }
}