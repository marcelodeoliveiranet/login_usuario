// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class BaseState {}

class LoadingState implements BaseState {}

class SuccessState implements BaseState {
  final String sucesso;

  SuccessState({required this.sucesso});
}

class ErrorState implements BaseState {
  final String erro;

  const ErrorState({required this.erro});
}

class IdleState implements BaseState {}
