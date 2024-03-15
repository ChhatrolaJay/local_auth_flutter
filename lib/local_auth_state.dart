part of 'local_auth_cubit.dart';

/// Define an abstract class 'LocalAuthState' to represent various states of local authentication
@immutable
abstract class LocalAuthState {}

/// Define a class 'LocalAuthInitial' representing the initial state of local authentication
class LocalAuthInitial extends LocalAuthState {}

/// Define a class 'BiometricSupportedState' representing the state where biometric authentication is supported
class BiometricSupportedState extends LocalAuthState {}

/// Define a class 'BiometricNotSupportedState' representing the state where biometric authentication is not supported
class BiometricNotSupportedState extends LocalAuthState {}

/// Define a class 'BiometricAuthenticationSuccessState' representing the state where biometric authentication is successful
class BiometricAuthenticationSuccessState extends LocalAuthState {}

/// Define a class 'BiometricAuthenticationFailedState' representing the state where biometric authentication fails
class BiometricAuthenticationFailedState extends LocalAuthState {}
