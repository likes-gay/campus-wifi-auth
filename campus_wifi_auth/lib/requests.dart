import 'package:campus_wifi_auth/enums.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

Future<RequestStatus> loginRequest(
    String url, String username, String password) async {
  var uri = Uri.parse(url).replace(path: '/login.xml');

  try {
    final response = await http.post(uri, body: {
      'username': username,
      'a': DateTime.now().millisecondsSinceEpoch,
      'producttype': 0, //Web = 0, iOS = 1, Android = 2,
      'mode': 193
    }).timeout(const Duration(seconds: 5));

    final responseBody = response.body;
    if (responseBody.contains('account is locked')) {
      return RequestStatus.locked;
    } else if (responseBody.contains('Log in failed')) {
      return RequestStatus.failed;
    } else if (!responseBody.contains('You are signed in as')) {
      return RequestStatus.unknownError;
    }

    return RequestStatus.unknownError;
  } on TimeoutException {
    return RequestStatus.timeout;
  } catch (e) {
    return RequestStatus.unknownError;
  }
}

Future<RequestStatus> logoutRequest(String url, String username) async {
  var uri = Uri.parse(url).replace(path: '/logout.xml');

  try {
    final response = await http.post(uri, body: {
      'username': username,
      'a': DateTime.now().millisecondsSinceEpoch,
      'producttype': 0, //Web = 0, iOS = 1, Android = 2,
      'mode': 193
    }).timeout(const Duration(seconds: 5));

    final responseBody = response.body;
    if (responseBody.contains("Logged out successfully")) {
      return RequestStatus.success;
    } else if (responseBody.contains("account is locked")) {
      return RequestStatus.locked;
    }

    return RequestStatus.unknownError;
  } on TimeoutException {
    return RequestStatus.timeout;
  } catch (e) {
    return RequestStatus.unknownError;
  }
}

Future<bool> checkConnection(String url) async {
  try {
    final response =
        await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}
