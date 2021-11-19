import 'package:coordinator/core/states.dart';
import 'package:flutter/material.dart';

/// This is the base class for coordinators, the start method is used
/// to initialize the coordinators ans setup the state machine, also
/// you can override it and implement some custom logic before the initialization
///
/// the send method is used to trigger new intentions to the state machine.

abstract class Coordinator<I extends Intention> {
  VoidCallback? coordinationDidFinish;

  void start({
    required BuildContext context,
    VoidCallback? coordinationDidFinish,
  });

  void send(BuildContext context, I _intention);
}
