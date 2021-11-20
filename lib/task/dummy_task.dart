import 'dart:async';

import 'package:coordinator/core/states.dart';
import 'package:coordinator/task/task.dart';

class DummyTask implements Task {
  @override
  FutureOr<Intention> execute() async {
    await Future.delayed(const Duration(seconds: 3));
    print('Task executed');
    return DataUpdatedAPI();
  }
}
