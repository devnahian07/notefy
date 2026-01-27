import 'package:flutter/material.dart';
import 'package:notefy/constants/routes.dart';
import 'package:notefy/services/auth/auth_service.dart';
import 'package:notefy/views/login_view.dart';
import 'package:notefy/views/notes/create_update_note_view.dart';
import 'package:notefy/views/notes/notes_view.dart';
import 'package:notefy/views/register_view.dart';
import 'package:notefy/views/verify_email_view.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      routes: {
        // the place where routes are registered
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.fireBase().initialize(),
      builder: (context, snapshot) {
        // builder function must return a widget
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.fireBase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
