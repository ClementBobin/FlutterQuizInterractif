import 'dart:convert';
import 'http_request_session.dart';

Future<dynamic> makeRequest(Session session, String method, String url, {String? csrfToken, Object? body}) async {
  final headers = {
    'Content-Type': 'application/json',
    if (csrfToken != null) 'X-CSRF-TOKEN': csrfToken,
  };

  final response = await session.request(
    method,
    url,
    headers: headers,
    body: body,
  );

  if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
    print('Request successful');
    return jsonDecode(response.body);
  } else {
    print('Request failed with status: ${response.statusCode}');
    throw Exception('Request failed with status: ${response.statusCode}');
  }
}