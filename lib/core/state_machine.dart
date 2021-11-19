import 'dart:collection';

import 'package:coordinator/core/states.dart';

class StateMachine<I extends Intention, SmState> {
  final HashMap<SmState, HashMap<I, SmState>> transitions = HashMap();

  final SmState start;
  final Set<SmState> endings;

  StateMachine({
    required this.start,
    required this.endings,
  });

  bool isStartState(SmState state) => start == state;

  bool isFinalState(SmState state) => endings.contains(state);

  SmState get getStart => start;

  void addTransition(
    SmState from,
    I intention,
    SmState to,
  ) {
    var fromTransitions = transitions[from];
    fromTransitions ??= HashMap();
    fromTransitions.putIfAbsent(intention, () => to);
    transitions.putIfAbsent(from, () => fromTransitions!);
  }

  SmState? getNextState(
    SmState from,
    I intention,
  ) =>
      transitions[from]?[intention];
}
