import 'package:coordinator/core/coordinator.dart';
import 'package:coordinator/core/state_machine_coordinator.dart';
import 'package:coordinator/core/states.dart';
import 'package:coordinator/router/route_observer.dart';
import 'package:coordinator/router/router.dart';
import 'package:coordinator/core/state_machine.dart';
import 'package:flutter/material.dart';

class SignUpNavigator {
  Coordinator? coordinator;

  NavigatorState _getNavigator(BuildContext context) => Navigator.of(context);

  void navigateToPersonalDataScreen(BuildContext context) {
    _getNavigator(context)
        .pushNamed(personalDataScreen, arguments: coordinator);
  }

  void navigateToEmailScreen(BuildContext context) {
    _getNavigator(context).pushNamed(emailScreen);
  }

  void navigateToNameScreen(BuildContext context) {
    _getNavigator(context).pushNamed(nameScreen);
  }
}

class SignUpCoordinator extends StateMachineCoordinator {
  final SignUpNavigator _navigator;

  SignUpCoordinator(
    StateMachine<Intention, MachineState> stateMachine,
    CoordinatorRouteObserver routeObserver,
    this._navigator,
  ) : super(stateMachine, routeObserver);

  @override
  void start({
    required BuildContext context,
    VoidCallback? coordinationDidFinish,
  }) {
    _navigator.coordinator = this;

    /// Setup everything before calling super

    super.start(
      coordinationDidFinish: coordinationDidFinish,
      context: context,
    );
  }

  @override
  void executeTask(Intention? intention, state) {
    // TODO: implement executeTask
  }

  @override
  void navigate(BuildContext context, Intention? intention, state) {
    final map = {
      SPersonalDataScreen: _navigator.navigateToPersonalDataScreen,
      SNameScreen: _navigator.navigateToNameScreen,
      SEmailScreen: _navigator.navigateToEmailScreen,
    };
    map[state.runtimeType]?.call(context);
  }

  @override
  void startCoordinator({
    required BuildContext context,
    required MachineState state,
    VoidCallback? coordinationDidFinish,
    Intention? intention,
  }) {
    // TODO: implement startCoordinator
  }
}
