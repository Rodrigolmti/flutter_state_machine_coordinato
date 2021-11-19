import 'dart:collection';

import 'package:coordinator/core/coordinator.dart';
import 'package:coordinator/core/states.dart';
import 'package:coordinator/core/state_machine.dart';
import 'package:coordinator/router/route_observer.dart';
import 'package:flutter/material.dart';

abstract class StateMachineCoordinator<I extends Intention>
    extends Coordinator<I> {
  final ListQueue<MachineState> stateHistory = ListQueue<MachineState>();
  final CoordinatorRouteObserver routeObserver;

  MachineState? get currentState {
    if (stateHistory.isNotEmpty) {
      return stateHistory.last;
    } else {
      return null;
    }
  }

  final StateMachine stateMachine;

  StateMachineCoordinator(this.stateMachine, this.routeObserver);

  @override
  void start({
    required BuildContext context,
    VoidCallback? coordinationDidFinish,
  }) {
    stateHistory.clear();

    routeObserver.subscribe(this);

    this.coordinationDidFinish = coordinationDidFinish;

    final start = stateMachine.getStart;
    stateHistory.add(start);
    applyState(context, start, null, start);

    print('$runtimeType history: $stateHistory');
  }

  @override
  void send(BuildContext context, I _intention) {
    try {
      final nextState = stateMachine.getNextState(currentState, _intention);
      if (nextState != null) {
        stateHistory.add(nextState);
        applyState(context, currentState!, _intention, nextState);

        print('$runtimeType updated history: $stateHistory');
      }
    } catch (_) {}
  }

  void popState() {
    MachineState? state;

    if (stateHistory.isEmpty) {
      print('$runtimeType empty history');
      return;
    }

    do {
      state = stateHistory.removeLast();

      print('$runtimeType popping ${state.runtimeType}');
    } while (stateHistory.length > 1 && state is ViewState);
    // } while (currentState is! ViewState && state is! ViewState);

    if (stateHistory.isEmpty) {
      coordinationDidFinish?.call();
      _onStop();
    }

    print('$runtimeType popped history: $stateHistory');
  }

  void _onStop() {
    print('$runtimeType lifecycle stopped');
    routeObserver.unsubscribe(this);
  }

  void _onResume() {
    print('$runtimeType lifecycle resumed, history: $stateHistory');
    routeObserver.subscribe(this);
    popState();
  }

  void applyState(
    BuildContext context,
    MachineState current,
    I? intention,
    MachineState next,
  ) {
    if (next is ViewState) {
      navigate(context, intention, next);
      return;
    }

    if (next is TaskState) {
      executeTask(intention, next);
      return;
    }

    if (next is CoordinatorState) {
      _onStop();

      startCoordinator(
        context: context,
        intention: intention,
        coordinationDidFinish: () => _onResume(),
        state: next,
      );
      return;
    }

    throw Exception('state $next implementation not supported');
  }

  void navigate(
    BuildContext context,
    I? intention,
    MachineState state,
  );

  void executeTask(
    I? intention,
    MachineState state,
  );

  void startCoordinator({
    required BuildContext context,
    required MachineState state,
    VoidCallback? coordinationDidFinish,
    Intention? intention,
  });
}
