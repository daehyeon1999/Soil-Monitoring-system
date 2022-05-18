import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

import '../settings/preferences.dart';

class User {
  String username, password;
  String? name;

  var token;
  String userId = '';
  User({required this.password, required this.username, this.name});

  //* Login process
  login() async {
    const url = "https://soil-analysis-usls.herokuapp.com/v1/user/login";
    // "http://localhost:3000/v1/user/login";
    var response = await http.post(Uri.parse(url),
        body: {'username': username, 'password': password});

    if (response.statusCode == 200) {
      var item = jsonDecode(response.body);
      LoginPreferences.saveToken(item['data']['authToken']);

      //* decode the token to get th userId
      var decodeToken = Jwt.parseJwt(item['data']['authToken']);

      //* save the userId
      userId = decodeToken['_id'];

      //* save the token into the class
      token = item['data']['authToken'];

      //* No user exist
    } else if (response.statusCode == 401) {
      token = false;
    }
  }

  //* Register process
  register() async {
    const url = "https://soil-analysis-usls.herokuapp.com/v1/user/create";
    // "http://localhost:3000/v1/user/create";
    var response = await http.post(Uri.parse(url),
        body: {'name': name, 'username': username, 'password': password});

    //* Success register
    if (response.statusCode == 200) {
      return true;
    }

    //* Failed register
    return false;
  }
}
