import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:notefy/constants/routes.dart';
import 'package:notefy/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email ')),
      body: Column(
        children: [
          const Text(
            'We\'ve already sent you an email. Open it to veriy your account.',
          ),
          const Text(
            'If you haven\'t received the email, then press the button below:',
          ),
          TextButton(
            onPressed: () async {
              await AuthService.fireBase().sendEmailVerification();
            },
            child: const Text('Send Verification Email'),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.fireBase().logOut();
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
