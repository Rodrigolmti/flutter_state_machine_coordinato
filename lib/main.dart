import 'package:coordinator/router/router.dart';
import 'package:coordinator/service_locator.dart';
import 'package:coordinator/ui/account_create_screen.dart';
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
