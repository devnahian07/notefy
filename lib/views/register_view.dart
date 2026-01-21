import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:notefy/constants/routes.dart';
import 'package:notefy/services/auth/auth_exceptions.dart';
import 'package:notefy/services/auth/auth_service.dart';
import 'package:notefy/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Enter your email'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Enter your password'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.fireBase().createUser(
                  email: email,
                  password: password,
                );
                await AuthService.fireBase().sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on WeakPasswordAuthException {
                await showErrorDialog(
                  context,
                  'Your password must be at least 8 characters long, including a number and a special character.',
                );
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(
                  context,
                  'The email address is already in use by another account.',
                );
              } on InvalidEmailAuthException {
                await showErrorDialog(context, 'Invalid email address');
              } on GenericAuthException {
                await showErrorDialog(context, 'Failed to register');
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text('Already Registered? Login Here!'),
          ),
        ],
      ),
    );
  }
}
