import 'package:coordinator/core/coordinator.dart';
import 'package:coordinator/core/states.dart';
import 'package:flutter/material.dart';

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
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  widget.coordinator.send(
                    context: context,
                    intention: AskName(),
                  );
                },
                child: const Text('go to Name'),
              ),
              OutlinedButton(
                onPressed: () {
                  widget.coordinator.send(
                    context: context,
                    intention: AskEmail(),
                  );
                },
                child: const Text('go to Email'),
              ),
            ],
          ),
        ),
      );
}
