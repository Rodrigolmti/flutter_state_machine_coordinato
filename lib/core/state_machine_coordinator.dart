import 'dart:async';
import 'dart:collection';

import 'package:coordinator/core/coordinator.dart';
import 'package:coordinator/core/states.dart';
import 'package:coordinator/core/state_machine.dart';
import 'package:coordinator/router/route_observer.dart';
import 'package:flutter/material.dart';

/// With this class we can control the state machine, and syncronize the navigation stack
/// with the stateHistory.
///
/// Every time that someone pops a screen on the navigation we need to pop the history too,
/// until we find the last [ViewState] that is the corresponding state with the current screen
abstract class StateMachineCoordinator extends Coordinator
    implements CoordinatorExecutor, CoordinatorLifecycle {
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

  StateMachineCoordinator(
    this.stateMachine,
    this.routeObserver,
  );

  @override
  void start({
    required BuildContext context,
    VoidCallback? coordinationDidFinish,
  }) {
    onStart();

    stateHistory.clear();

    routeObserver.subscribe(this);

    this.coordinationDidFinish = coordinationDidFinish;

    final start = stateMachine.getStart;
    stateHistory.add(start);

    _applyState(
      context: context,
      state: start,
    );

    print('$runtimeType history: $stateHistory');
  }

  @override
  void send({
    required BuildContext context,
    required Intention intention,
    VoidCallback? onJobCompleted,
  }) {
    try {
      final nextState = stateMachine.getNextState(currentState, intention);
      if (nextState != null) {
        stateHistory.add(nextState);
        _applyState(
          context: context,
          intention: intention,
          state: nextState,
          onJobCompleted: onJobCompleted,
        );

        print('$runtimeType updated history: $stateHistory');
      }
    } catch (error) {
      print('$runtimeType error: $error');
    }
  }

  @override
  void onStart() {
    print('$runtimeType lifecycle started');
  }

  @override
  void onStop() {
    print('$runtimeType lifecycle stopped');
    routeObserver.unsubscribe(this);
  }

  @override
  void onResume() {
    print('$runtimeType lifecycle resumed, history: $stateHistory');
    routeObserver.subscribe(this);
    popState();
  }

  Future<void> _applyState({
    required BuildContext context,
    required MachineState state,
    VoidCallback? onJobCompleted,
    Intention? intention,
  }) async {
    if (state is ViewState) {
      navigateToScreen(context, intention, state);
      return;
    }

    if (state is TaskState) {
      await executeTask(
        context: context,
        intention: intention,
        state: state,
      );

      print('$runtimeType finishing up task callback');

      /// Notify the view that the job is done
      onJobCompleted?.call();

      popState();

      return;
    }

    if (state is CoordinatorState) {
      /// Put the current coordinator in a stop mode, so it can't receive updates
      onStop();

      startCoordinator(
        context: context,
        intention: intention,
        coordinationDidFinish: () => onResume(),
        state: state,
      );
      return;
    }

    throw Exception('state $state implementation not supported');
  }

  void popState() {
    MachineState? state;

    if (stateHistory.isEmpty) {
      print('$runtimeType empty history');
      _finishCoordinatorLifecycle();
      return;
    }

    do {
      state = stateHistory.removeLast();

      print('$runtimeType popping ${state.runtimeType}');
    } while (stateHistory.length > 1 && state is ViewState);

    if (stateHistory.isEmpty) {
      _finishCoordinatorLifecycle();
    }

    print('$runtimeType popped history: $stateHistory');
  }

  void _finishCoordinatorLifecycle() {
    coordinationDidFinish?.call();
    onStop();
  }
}
