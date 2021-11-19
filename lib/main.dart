import 'package:coordinator/core/coordinator.dart';
import 'package:coordinator/core/states.dart';

import 'package:coordinator/router/router.dart';
import 'package:coordinator/service_locator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorObservers: [SL.I.router],
      onGenerateRoute: routeGeneration,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AccountCreatedScreen(),
    );
  }
}

class AccountCreatedScreen extends StatefulWidget {
  const AccountCreatedScreen({Key? key}) : super(key: key);

  @override
  State<AccountCreatedScreen> createState() => _AccountCreatedScreenState();
}

class _AccountCreatedScreenState extends State<AccountCreatedScreen> {
  @override
  void initState() {
    super.initState();

    SL.I.verifyIdentityCoordinator.start(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Machine'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
              onPressed: () {
                SL.I.verifyIdentityCoordinator.send(context, StartSignUp());
              },
              child: const Text('Start sign up'),
            ),
            OutlinedButton(
              onPressed: () {
                SL.I.verifyIdentityCoordinator.send(context, StartReSubimit());
              },
              child: const Text('Start re subimit'),
            ),
          ],
        ),
      ),
    );
  }
}

class PersonalDataScreen extends StatefulWidget {
  final Coordinator coordinator;

  const PersonalDataScreen({required this.coordinator, Key? key})
      : super(key: key);

  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Personal Data'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Coordinator ${widget.coordinator.runtimeType}'),
              OutlinedButton(
                onPressed: () {
                  widget.coordinator.send(context, AskName());
                },
                child: const Text('go to Name'),
              ),
              OutlinedButton(
                onPressed: () {
                  widget.coordinator.send(context, AskEmail());
                },
                child: const Text('go to Email'),
              ),
            ],
          ),
        ),
      );
}

class NameScreen extends StatefulWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Name Screen'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Name screen'),
          ],
        ),
      );
}

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Email Screen'),
        ),
        body: Center(
          child: Column(
            children: const [
              Text('Email screen'),
            ],
          ),
        ),
      );
}
