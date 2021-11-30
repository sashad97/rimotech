import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:rimotech/util/http/response_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpService {
  final String _baseUrl;

  HttpService(this._baseUrl);
  String get baseUrl => _baseUrl;

  Future<dynamic> get(String path) async {
    final String url = baseUrl + path;
    http.Response response;
    print('Request::URL: $url');
    response = await http
        .get(Uri.parse(url), headers: await getHeaders())
        .timeout(const Duration(seconds: 40));

    return handleResponse(response);
  }

  Future<dynamic> post(String path, Map<dynamic, dynamic> body) async {
    final String url = baseUrl + path;
    print('URL:: $url, body:: ${json.encode(body)}');

    final response = await http
        .post(Uri.parse(url),
            headers: await getHeaders(), body: json.encode(body))
        .timeout(const Duration(seconds: 60));

    return handleResponse(response);
  }

  Future<dynamic> patch(String path, Map<dynamic, dynamic> body) async {
    final String url = _baseUrl + path;
    print('URL:: $url, body:: ${json.encode(body)}');

    final response = await http
        .patch(Uri.parse(url),
            headers: await getHeaders(), body: json.encode(body))
        .timeout(const Duration(seconds: 30));

    return handleResponse(response);
  }

  Future<dynamic> put(String path, Map<dynamic, dynamic> body) async {
    final String url = _baseUrl + path;
    print('URL:: $url, body:: ${json.encode(body)}');

    final response = await http
        .patch(Uri.parse(url),
            headers: await getHeaders(), body: json.encode(body))
        .timeout(const Duration(seconds: 30));

    return handleResponse(response);
  }

  Future<dynamic> delete(String path, Map<dynamic, dynamic> body) async {
    final String url = _baseUrl + path;
    print('URL:: $url body:: $path');

    final response = await http
        .delete(Uri.parse(url),
            headers: await getHeaders(), body: json.encode(body))
        .timeout(const Duration(seconds: 30));

    return handleResponse(response);
  }

  getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var t = prefs.getString('token');
    print('token $t');
    if (t != null) {
      return <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $t"
      };
    } else {
      return <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      };
    }
  }
}
