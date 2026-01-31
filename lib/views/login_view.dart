import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notefy/services/auth/auth_exceptions.dart';
import 'package:notefy/services/auth/bloc/auth_bloc.dart';
import 'package:notefy/services/auth/bloc/auth_event.dart';
import 'package:notefy/services/auth/bloc/auth_state.dart';
import 'package:notefy/utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        if (state is AuthStateLoggedOut) {
          final exc = state.exception;
          if (exc is UserNotFoundAuthException ||
              exc is WrongPasswordAuthException) {
            await showErrorDialog(
              context,
              'Can not find a user with the given credentials.',
            );
          } else if (exc is GenericAuthException) {
            await showErrorDialog(context, 'Authentication error');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Log in to your account to create and share notes!',
                style: TextStyle(fontSize: 15),
              ),
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
                          AuthEventLogIn(email, password),
                        );
                        // catch(e){ //catches every error
                        //   print(e.runtimeType); // type of the exception
                        // }
                      },
                      child: const Text('Login'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          const AuthEventForgotPassword(email: null),
                        );
                      },
                      child: const Text('Forgot password?'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          const AuthEventShouldRegister(),
                        );
                      },
                      child: const Text('Not Registered Yet? Register Here!'),
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
