import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_flutter/local_auth_code.dart';

part 'local_auth_state.dart';

class LocalAuthCubit extends Cubit<LocalAuthState> {
  final LocalAuthentication _localAuth = LocalAuthentication();

  LocalAuthCubit() : super(LocalAuthInitial());

  /// this list will contain Biometric type sucha as Strong or week.
  late List<BiometricType> biometricTypes;

  /// this boolean will change the icon for face or fingerprint.
  bool? isFaceIdOnly;

  Future<void> getAvailableBiometric() async {
    late List<BiometricType> biometricTypes;
    try {
      /// method will get the available biometrics of the given device.
      biometricTypes = await _localAuth.getAvailableBiometrics();
      bool canCheckBiometric = await _localAuth.canCheckBiometrics;
      if(biometricTypes.isEmpty || !canCheckBiometric){
        emit(BiometricNotSupportedState());
      } else{
        isFaceIdOnly = !biometricTypes.contains(BiometricType.strong);
        emit(BiometricSupportedState());
      }

    } on PlatformException catch (e) {
      debugPrint('Error occurred ${e.message}');
    }
  }

  Future<void> startBiometricAuth(
      {AuthenticationOptions? authenticationOptions,
      String? displayTitle}) async {
    try {
      /// this method will provide boolean for checking biometrics.
      bool canCheckBiometric = await _localAuth.canCheckBiometrics;
      if (canCheckBiometric) {
        /// if canCheckBiometric is true will do authentication.
        _authenticateWithBiometrics(
            authenticationOptions: authenticationOptions,
            displayTitle: displayTitle);
      } else {
        emit(BiometricNotSupportedState());
      }
    } on Exception {
      emit(BiometricNotSupportedState());
    }
  }

  Future<void> _authenticateWithBiometrics(
      {AuthenticationOptions? authenticationOptions,
      String? displayTitle}) async {
    try {
      /// this method will perform authentication
      /// and will emit the states accordingly.
      final bool authenticated = await _localAuth.authenticate(
          localizedReason: displayTitle ??
              'Authenticate with Fingerprint or Face ID', // parameter
          options: authenticationOptions ??
              const AuthenticationOptions(
                stickyAuth: true, // parameter
                biometricOnly: false,
              ));
      if (authenticated) {
        emit(BiometricAuthenticationSuccessState());
      } else {
        emit(BiometricAuthenticationFailedState());
      }
    } on Exception {
      emit(BiometricAuthenticationFailedState());
    }
  }
}
