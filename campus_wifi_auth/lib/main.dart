// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:campus_wifi_auth/enums.dart';
import 'package:campus_wifi_auth/requests.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => LoginState(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Campus Wi-Fi Auth', home: navigationAndContent());
  }
}

class LoginState extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void toggle() {
    print('Toggling');
    if (_isLoggedIn) {
      logout();
    } else {
      login();
    }
  }
}

class navigationAndContent extends StatefulWidget {
  const navigationAndContent({super.key});

  @override
  State<navigationAndContent> createState() => _navigationAndContentState();
}

class _navigationAndContentState extends State<navigationAndContent> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget pageContent;

    switch (selectedIndex) {
      case 0:
        pageContent = const togglePage();
      case 1:
        pageContent = const credsPage();
      default:
        return const Placeholder();
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.toggle_on),
            label: 'Toggle',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Credentials',
          ),
        ],
      ),
      body: Center(
        child: pageContent,
      ),
    );
  }
}

class togglePage extends StatelessWidget {
  const togglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [loginLogoutButton()],
    );
  }
}

class credsPage extends StatelessWidget {
  const credsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [Text("Creds Page")],
    );
  }
}

class loginLogoutButton extends StatelessWidget {
  const loginLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final loginState = Provider.of<LoginState>(context);
    return Column(children: [
      IconButton(
          icon: const Icon(Icons.power_settings_new),
          iconSize: 300,
          onPressed: () {
            loginState.toggle();
          }),
      Text(loginState.isLoggedIn ? 'Logged In' : 'Logged Out')
    ]);
  }
}
