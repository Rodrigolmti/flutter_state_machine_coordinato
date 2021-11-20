import 'dart:async';

import 'package:coordinator/core/states.dart';

/// The ideia of a task is to take out from the coordinator the responsability
/// of handling business rules, so we can inject the useCase on it and do
/// some work, while the view is waiting.
abstract class Task {
  FutureOr<Intention> execute();
}
