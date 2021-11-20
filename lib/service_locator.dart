import 'package:coordinator/coordinators/re_subimit_coordinator.dart';
import 'package:coordinator/core/coordinator.dart';
import 'package:coordinator/core/states.dart';
import 'package:coordinator/router/route_observer.dart';
import 'package:coordinator/coordinators/sign_up_coordinator.dart';
import 'package:coordinator/core/state_machine.dart';
import 'package:coordinator/coordinators/verify_identity_coordinator.dart';
import 'package:coordinator/task/dummy_task.dart';

class SL {
  SL._() {
    _verifyIdentity();
    _reSubimit();
    _signUp();
  }

  static final SL I = SL._();

  CoordinatorRouteObserver router = CoordinatorRouteObserver.I;

  late Coordinator verifyIdentityCoordinator;
  late Coordinator signUpCoordinator;
  late Coordinator reSubimitCoordinator;

  late DummyTask dummyTask;

  void _verifyIdentity() {
    dummyTask = DummyTask();

    final stateMachine = StateMachine<Intention, MachineState>(
      start: SAccountCreatedScreen(),
      endings: {SEmailScreen()},
    )
      ..addTransition(
          SAccountCreatedScreen(), StartSignUp(), SignUpStateCoordinator())
      ..addTransition(SAccountCreatedScreen(), StartReSubimit(),
          ReSubimitStateCoordinator());

    verifyIdentityCoordinator = VerifyIdentityCoordinator(stateMachine, router);
  }

  void _reSubimit() {
    final stateMachine = StateMachine<Intention, MachineState>(
      start: SPersonalDataScreen(),
      endings: {SEmailScreen()},
    )
      ..addTransition(SPersonalDataScreen(), AskName(), SNameScreen())
      ..addTransition(SPersonalDataScreen(), AskEmail(), SEmailScreen());

    final navigator = ReSubimitNavigator();

    reSubimitCoordinator =
        ReSubimitCoordinator(stateMachine, router, navigator);
  }

  void _signUp() {
    final stateMachine = StateMachine<Intention, MachineState>(
      start: SPersonalDataScreen(),
      endings: {SEmailScreen()},
    )
      ..addTransition(SPersonalDataScreen(), AskName(), SNameScreen())
      ..addTransition(SPersonalDataScreen(), AskEmail(), SEmailScreen())
      ..addTransition(SEmailScreen(), SendDataToAPI(), ExecuteDummyTask());

    final navigator = SignUpNavigator();

    signUpCoordinator = SignUpCoordinator(stateMachine, router, navigator);
  }
}
