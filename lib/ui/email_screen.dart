import 'package:coordinator/core/coordinator.dart';
import 'package:coordinator/core/states.dart';
import 'package:flutter/material.dart';

class EmailScreen extends StatefulWidget {
  final Coordinator coordinator;

  const EmailScreen({required this.coordinator, Key? key}) : super(key: key);

  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Email Screen'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading) ...[
                const CircularProgressIndicator(),
              ] else ...[
                const Text('Email screen'),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
                    setState(() => _isLoading = true);

                    widget.coordinator.send(
                      context: context,
                      intention: SendDataToAPI(),
                      onJobCompleted: () {
                        setState(() => _isLoading = false);
                      },
                    );
                  },
                  child: const Text('Update data'),
                ),
              ],
            ],
          ),
        ),
      );
}
