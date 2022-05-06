import 'package:flutter/material.dart';

import '../widgets/login_section.dart';
import '../widgets/register_section.dart';

enum _AuthType { login, register }

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const path = "/auth";

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  _AuthType _authType = _AuthType.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedCrossFade(
          firstChild: LoginSection(
            onChangeRegisterPressed: () => setState(() {
              _authType = _AuthType.register;
            }),
          ),
          secondChild: RegisterSection(
            onChangeLoginPressed: () => setState(() {
              _authType = _AuthType.login;
            }),
          ),
          duration: const Duration(milliseconds: 300),
          crossFadeState: _authType == _AuthType.login
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ),
      ),
    );
  }
}
