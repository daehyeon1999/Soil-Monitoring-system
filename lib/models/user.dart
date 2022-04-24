import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:ndialog/ndialog.dart';
import '../loading.dart';
import '../settings/preferences.dart';

class User {
  final username, password;
  final name;
  static String userId = "";
  static dynamic token = "";
  User({required this.username, required this.password, this.name});

  login(context) async {
    //show dialog
    CustomProgressDialog loadingDialog = CustomProgressDialog(
      context,
      blur: 10,
      dismissable: false,
      loadingWidget: const Center(child: LoadingPage()),
    );
    loadingDialog.show();

    const url = "https://soil-analysis-system.herokuapp.com/v1/user/login";
    var response = await http.post(Uri.parse(url),
        body: {'username': username, 'password': password});

    if (response.statusCode == 200) {
      var item = jsonDecode(response.body);
      LoginPreferences.saveToken(item['data']['authToken']);

      // decode the token to get th userId
      var decodeToken = Jwt.parseJwt(item['data']['authToken']);

      // save the userId
      userId = decodeToken['_id'];

      //save the token into the class
      token = item['data']['authToken'];
      // No user exist
    } else if (response.statusCode == 401) {
      loadingDialog.dismiss();
      token = false;

      // Server is offline
    }
  }

  //TODO: fix this
  register() async {
    const url = "https://soil-analysis-system.herokuapp.com/v1/user/create";
    var response = await http.post(Uri.parse(url),
        body: {'name': name, 'username': username, 'password': password});
    if (response.statusCode == 200) {
      return true;
    }
    print(jsonDecode(response.body));
    return false;
  }
}