import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: AuthService.fireBase().initialize(),
//       builder: (context, snapshot) {
//         // builder function must return a widget
//         switch (snapshot.connectionState) {
//           case ConnectionState.done:
//             final user = AuthService.fireBase().currentUser;
//             if (user != null) {
//               if (user.isEmailVerified) {
//                 return const NotesView();
//               } else {
//                 return const VerifyEmailView();
//               }
//             } else {
//               return const LoginView();
//             }
//           default:
//             return const CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return BlocProvider(
      create: (context) => CounterBloc(), // an instance of our bloc provider
      child: Scaffold(
        appBar: AppBar(title: const Text('Testing Bloc')),
        body: BlocConsumer<CounterBloc, CounterState>(
          // listener and builder on the same level can be accessed by consumer
          listener: (context, state) {  // by listening for any new state appearing we will clear the current text field
            _controller.clear();
          },
          builder: (context, state) {
            final invalidValue = (state is CounterStateInvalidNumber)
                ? state.invalidValue
                : '';
            return Column(
              children: [
                Text('Current value: ${state.value}'),
                Visibility(
                  child: Text('Invalid input: ${invalidValue}'),
                  visible: state is CounterStateInvalidNumber,
                ),
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hint: Text('Enter a valid number'),
                  ),
                  keyboardType: TextInputType.number,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        context.read<CounterBloc>().add(
                          IncrementEvent(_controller.text),
                        ); // sending an event
                      },
                      child: Icon(Icons.add),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<CounterBloc>().add(
                          DecrementEvent(_controller.text),
                        );
                      },
                      child: Icon(Icons.remove),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

@immutable
abstract class CounterState {
  final int value;
  const CounterState(this.value);
}

class CounterStateValid extends CounterState {
  const CounterStateValid(int value) : super(value);
}

class CounterStateInvalidNumber extends CounterState {
  final String invalidValue;
  const CounterStateInvalidNumber({
    required this.invalidValue,
    required int previousValue,
  }) : super(previousValue);
}

@immutable
abstract class CounterEvent {
  final String value;
  const CounterEvent(this.value);
}

class IncrementEvent extends CounterEvent {
  const IncrementEvent(String value) : super(value);
}

class DecrementEvent extends CounterEvent {
  const DecrementEvent(String value) : super(value);
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterStateValid(0)) {
    // we have to pass an initial event to the super
    on<IncrementEvent>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(
          // for outputting a state from bloc
          CounterStateInvalidNumber(
            invalidValue: event.value,
            previousValue: state
                .value, // we can use state from anywhere in the CounterBloc to get the current state
          ),
        );
      } else {
        emit(
          CounterStateValid(state.value + integer),
        ); // state.value -> current value, integer -> given value
      }
    });
    on<DecrementEvent>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(
          // for outputting a state from bloc
          CounterStateInvalidNumber(
            invalidValue: event.value,
            previousValue: state
                .value, // we can use state from anywhere in the CounterBloc to get the current state
          ),
        );
      } else {
        emit(
          CounterStateValid(state.value - integer),
        ); // state.value -> current value, integer -> given value
      }
    });
  }
}
