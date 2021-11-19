import 'package:coordinator/core/state_machine_coordinator.dart';
import 'package:flutter/material.dart';

/// This route obsever is used to syncronize the navigation stack with
/// the state history, every time that we pop one screen we need to
/// pop the states in the history until the ViewState
///
/// Each coordinator needs to subscribe to it, so it can listen to
/// changes.
class CoordinatorRouteObserver extends NavigatorObserver {
  CoordinatorRouteObserver._();

  static final CoordinatorRouteObserver I = CoordinatorRouteObserver._();

  final Set<StateMachineCoordinator> coordinators = {};

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // try {

    final list = List<StateMachineCoordinator>.from(coordinators);
    for (final coord in list) {
      coord.popState();
    }
    // } catch (_) {
    // Transform this class in concurrency safe, to avoid multiple changes on
    // }
  }

  void subscribe(StateMachineCoordinator coordinator) {
    coordinators.add(coordinator);
  }

  void unsubscribe(StateMachineCoordinator coordinator) {
    coordinators.remove(coordinator);
  }
}
