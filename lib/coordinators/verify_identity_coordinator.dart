import 'dart:async';

import 'package:coordinator/core/state_machine_coordinator.dart';
import 'package:coordinator/core/states.dart';
import 'package:coordinator/router/route_observer.dart';
import 'package:coordinator/service_locator.dart';
import 'package:coordinator/core/state_machine.dart';
import 'package:flutter/material.dart';

class VerifyIdentityCoordinator extends StateMachineCoordinator {
  VerifyIdentityCoordinator(
    StateMachine<Intention, MachineState> stateMachine,
    CoordinatorRouteObserver routeObserver,
  ) : super(stateMachine, routeObserver);

  @override
  FutureOr<void> executeTask({
    required BuildContext context,
    required MachineState state,
    Intention? intention,
  }) {
    // TODO: implement executeTask
  }

  @override
  void navigateToScreen(BuildContext context, Intention? intention, state) {}

  @override
  void startCoordinator({
    required BuildContext context,
    required MachineState state,
    VoidCallback? coordinationDidFinish,
    Intention? intention,
  }) {
    if (state is ReSubimitStateCoordinator) {
      SL.I.reSubimitCoordinator.start(
        coordinationDidFinish: coordinationDidFinish,
        context: context,
      );
      return;
    }

    if (state is SignUpStateCoordinator) {
      SL.I.signUpCoordinator.start(
        coordinationDidFinish: coordinationDidFinish,
        context: context,
      );
    }
  }
}
