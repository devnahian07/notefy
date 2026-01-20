import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notefy/firebase_options.dart';
import 'package:notefy/views/login_view.dart';
import 'package:notefy/views/register_view.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView()
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          // builder function must return a widget
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              print(user);
              // if (user?.emailVerified ?? false) {
              //   return const Text('Done');
              // } else {
              //   print('Your email is not verified');
              //   return const VerifyEmailView();
              //   // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const VerifyEmailView()));
              // }
              return const LoginView();
            default:
              return const CircularProgressIndicator();
          }
        },
      );
  }
}