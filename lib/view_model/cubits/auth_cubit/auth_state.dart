part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class CreateAccountSuccess extends AuthState {}

final class CreateAccountLoading extends AuthState {}

final class CreateAccountError extends AuthState {}

final class SignInError extends AuthState {}

final class SignInLoading extends AuthState {}

final class SignInSuccess extends AuthState {}
