import 'package:equatable/equatable.dart';

/// Para resolver o problema do fluxo de re-submit
/// coordinator + maquina de estados
///
/// Problema:
/// Temos telas que são utilizadas em fluxos diferentes
///
/// Solução:
/// Tirar toda a responsabilidade das telas sobre fluxos
/// uma vez que a tela finaliza seu proposito, ela envia uma intention
/// para o coordinator, o qual analisa o fluxo, e baseado nisto ele decide
/// qual sera o proxímo passo

/// States

/// We can have three types of state [ViewState], [TaskState] and [CoordinatorState]
/// [ViewState] It is used to render screens, so it reflects your flow screens
/// [TaskState] It is used to handle async work, for example call a useCase to
/// update some date, doing with the task we take the responsability out of the coordinator
/// [CoordinatorState] It is used to open a new coordinator in the flow
abstract class MachineState extends Equatable {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

abstract class ViewState extends MachineState {}

abstract class TaskState extends MachineState {}

abstract class CoordinatorState extends MachineState {}

/// Coordinators

class VerifyIdentityStateCoordinator extends CoordinatorState {}

class ReSubimitStateCoordinator extends CoordinatorState {}

class SignUpStateCoordinator extends CoordinatorState {}

/// Flows

class SAccountCreatedScreen extends ViewState {}

class SPersonalDataScreen extends ViewState {}

class SNameScreen extends ViewState {}

class SEmailScreen extends ViewState {}

/// Intentions

/// Each intention reflects a user interations or something that
/// happens on the screen, we use intentions to change states.
abstract class Intention extends Equatable {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class StartSignUp extends Intention {}

class StartReSubimit extends Intention {}

class AskName extends Intention {}

class AskEmail extends Intention {}
