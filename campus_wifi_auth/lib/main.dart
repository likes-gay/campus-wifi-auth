// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:campus_wifi_auth/enums.dart';
import 'package:campus_wifi_auth/requests.dart';
import 'package:window_manager/window_manager.dart';

// Pages
import 'package:campus_wifi_auth/pages/credentials.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(190, 200),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      title: 'Campus Wi-Fi Auth',
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.setResizable(false);
    });
  }

  runApp(ChangeNotifierProvider(
      create: (context) => LoginState(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Campus Wi-Fi Auth', home: NavigationAndContent());
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

class NavigationAndContent extends StatefulWidget {
  const NavigationAndContent({super.key});

  @override
  State<NavigationAndContent> createState() => _NavigationAndContentState();
}

class _NavigationAndContentState extends State<NavigationAndContent> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget pageContent;

    switch (selectedIndex) {
      case 0:
        pageContent = const TogglePage();
      case 1:
        pageContent = const CredsPage();
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

class TogglePage extends StatelessWidget {
  const TogglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [LoginLogoutButton()],
    );
  }
}

class LoginLogoutButton extends StatelessWidget {
  const LoginLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final loginState = Provider.of<LoginState>(context);
    return Expanded(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              child: IconButton(
                icon: const Icon(Icons.power_settings_new),
                onPressed: () {
                  loginState.toggle();
                },
              ),
            ),
            Text(loginState.isLoggedIn ? 'Logged In' : 'Logged Out')
          ]),
    );
  }
}
