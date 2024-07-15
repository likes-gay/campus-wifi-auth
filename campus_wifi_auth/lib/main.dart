import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Campus Wi-Fi Auth',
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                loginLogoutButton(),
              ],
            ),
          ),
        ));
  }
}

class togglePage extends StatelessWidget {
  const togglePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text("Toggle Page")],
    );
  }
}

class credsPage extends StatelessWidget {
  const credsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text("Creds Page")],
    );
  }
}

class loginLogoutButton extends StatefulWidget {
  const loginLogoutButton({Key? key}) : super(key: key);

  @override
  State<loginLogoutButton> createState() => _loginLogoutButtonState();
}

class _loginLogoutButtonState extends State<loginLogoutButton> {
  var buttonPressedCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      IconButton(
          icon: const Icon(Icons.power_settings_new),
          iconSize: 300,
          onPressed: () {
            print('Button pressed');
            setState(() {
              buttonPressedCount++;
            });
          }),
      Text('button pressed $buttonPressedCount times')
    ]);
  }
}
