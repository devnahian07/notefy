import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notefy/services/auth/auth_exceptions.dart';
import 'package:notefy/services/auth/bloc/auth_bloc.dart';
import 'package:notefy/services/auth/bloc/auth_event.dart';
import 'package:notefy/services/auth/bloc/auth_state.dart';
import 'package:notefy/utilities/dialogs/error_dialog.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          final exc = state.exception;
          if (exc is WeakPasswordAuthException) {
            await showErrorDialog(
              context,
              'Your password must be at least 8 characters long, including a number and a special character.',
            );
          } else if (exc is EmailAlreadyInUseAuthException) {
            await showErrorDialog(
              context,
              'The email address is already in use by another account.',
            );
          } else if (exc is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Invalid email address');
          } else if (exc is GenericAuthException) {
            await showErrorDialog(context, 'Failed to register');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .start, // this will stop the column widget from aligning its contents horizontally
            children: [
              const Text(
                'Enter your email and password to start!',
                style: TextStyle(fontSize: 15),
              ),
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'Enter your email'),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                ),
              ),
              Center(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;
                        context.read<AuthBloc>().add(
                          AuthEventRegister(email, password),
                        );
                      },
                      child: const Text('Register'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(const AuthEventLogOut());
                      },
                      child: const Text('Already Registered? Login Here!'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
