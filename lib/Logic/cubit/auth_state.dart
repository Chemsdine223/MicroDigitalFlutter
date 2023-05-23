part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSuccess extends AuthState {
  final User user;

  AuthSuccess(this.user);

  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  final String errorMsg;
  AuthError({
    required this.errorMsg,
  });
  @override
  List<Object?> get props => [errorMsg];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class FirstTimeUser extends AuthState {
  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class Disconnected extends AuthState {
  final String errorMsg;
  Disconnected({
    required this.errorMsg,
  });

  @override
  List<Object?> get props => [errorMsg];
}

class SignUpSuccess extends AuthState {
  final String success;
  SignUpSuccess({
    required this.success
  });

  @override
  List<Object?> get props => [success];
}
