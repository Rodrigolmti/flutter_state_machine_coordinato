import 'package:coordinator/core/states.dart';
import 'package:coordinator/service_locator.dart';
import 'package:flutter/material.dart';

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
                SL.I.verifyIdentityCoordinator.send(
                  context: context,
                  intention: StartSignUp(),
                );
              },
              child: const Text('Start sign up'),
            ),
            OutlinedButton(
              onPressed: () {
                SL.I.verifyIdentityCoordinator.send(
                  context: context,
                  intention: StartReSubimit(),
                );
              },
              child: const Text('Start re subimit'),
            ),
          ],
        ),
      ),
    );
  }
}
