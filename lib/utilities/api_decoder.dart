import 'dart:convert';
import 'package:http/http.dart';
import '../models/login_response.dart';

class APIDecoder {
  LoginResponse decodeAuthResponse(Response response) {
    var body = json.decode(response.body);
    if (body['response']) return LoginResponse(true, null);

    return LoginResponse(body['response'], body['reason']);
  }
}