import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CredsPage extends StatefulWidget {
  const CredsPage({super.key});

  @override
  State<CredsPage> createState() => _CredsPageState();
}

class _CredsPageState extends State<CredsPage> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void saveFields() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", _usernameController.text);
    prefs.setString("password", _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Username',
          ),
          controller: _usernameController,
          onTapOutside: (e) => saveFields(),
          
        ),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
          controller: _passwordController,
          obscureText: true,
          onTapOutside: (e) => saveFields(),
        ),
      ],
    ),
    );
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      _usernameController.text = prefs.getString("username") ?? '';
      _passwordController.text = prefs.getString("password") ?? '';
    });
  }
}