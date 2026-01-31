import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notefy/services/auth/bloc/auth_bloc.dart';
import 'package:notefy/services/auth/bloc/auth_event.dart';
import 'package:notefy/services/auth/bloc/auth_state.dart';
import 'package:notefy/utilities/dialogs/error_dialog.dart';
import 'package:notefy/utilities/dialogs/password_reset_email_sent_dialog.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        // listener listens to the current state and based on that executes
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            await showPasswordResetSentDialog(context);
          }
          if (state.exception != null) {
            await showErrorDialog(
              context,
              'Failed to sent reset password email. Enter correct email',
            );
          }
        }
      },
      child: Scaffold(appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('If you forgot your password, simply enter your email and we will send you a password reset link'),
            TextField(
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              autofocus: true, // when the user ends up on that screen the text field automatically raises the keyboard
              controller: _controller,
              decoration: const InputDecoration(
                hint: Text('Enter your email'),
              ),
            ),
            TextButton(onPressed: () {
              final email = _controller.text;
              context.read<AuthBloc>().add(AuthEventForgotPassword(email: email));
            }, child: const Text('Send Password Reset Link')),
            TextButton(onPressed: () {
              context.read<AuthBloc>().add(AuthEventLogOut());
            }, child: const Text('Back to Login'))
          ],
        ),
      ),),
    );
  }
}
