library local_auth_flutter;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_flutter/local_auth_cubit.dart';
part 'local_auth_options.dart';

///Meditab Software Inc. CONFIDENTIAL
///__________________
///
/// [2024] Meditab Software Inc.
/// All Rights Reserved.
///
///NOTICE:  All information contained herein is, and remains
///the property of Meditab Software Inc. and its suppliers,
///if any.  The intellectual and technical concepts contained
///herein are proprietary to Meditab Software Incorporated
///and its suppliers and may be covered by U.S. and Foreign Patents,
///patents in process, and are protected by trade secret or copyright law.
///Dissemination of this information or reproduction of this material
///is strictly forbidden unless prior written permission is obtained
///from Meditab Software Incorporated.
///
///File Name: local_auth_code
///
///@author Jay Chhatrola (jayc@meditab.com) Meditab Software Inc.
///@version 1.0.0
///@since 22/02/24 1:19 PM
///

/// A widget that provides local authentication capabilities such as fingerprint or face ID.
class LocalAuthWidget extends StatefulWidget {
  /// Constructs a [LocalAuthWidget].
  ///
  /// - [localAuthListener] is a function that takes [BuildContext] and [LocalAuthState].
  /// It is used for handling navigation within your application.
  ///
  /// - [widgetBuilder] is an optional function that provides custom widget building for authentication.
  /// It takes [BuildContext], a boolean indicating whether Face ID is enabled, and a function to start authentication.
  ///
  /// - [authenticationOptions] is an optional parameter for custom authentication options.
  ///
  /// - [displayTitle] specifies the title to be displayed on the authentication dialog.
  const LocalAuthWidget(
      {super.key,
      required this.localAuthListener,
      this.displayTitle,
      this.widgetBuilder,
      this.isBiometricOnly});

  /// This function takes the listener function so it just use for
  /// handle navigation purpose in your application.
  final void Function(BuildContext context, LocalAuthState localAuthState)
      localAuthListener;

  /// This feature is optional as you need to add your custom widget
  /// and to use the generic authentication this will be useful.
  final Widget Function(BuildContext context, bool isFaceIdEnabled,
      Function() startAuthFunction)? widgetBuilder;

  /// This parameter takes the custom options for the authentications.
  final bool? isBiometricOnly;

  /// You can also pass what title should be displayed
  /// on the dialog of authentication.
  final String? displayTitle;

  @override
  State<LocalAuthWidget> createState() => _LocalAuthWidgetState();
}

class _LocalAuthWidgetState extends State<LocalAuthWidget> {
  /// Initialising the localAuthCubit
  late final LocalAuthCubit _localAuthCubit;

  @override
  void initState() {
    super.initState();
    _localAuthCubit = LocalAuthCubit();
    _localAuthCubit.getAvailableBiometric();
  }

  @override
  void dispose() {
    super.dispose();
    _localAuthCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _localAuthCubit,
      listener: widget.localAuthListener,
      builder: (context, state) {
        return state is! BiometricNotSupportedState
            ? InkWell(
                onTap: widget.widgetBuilder != null
                    ? null
                    : () {
                        _localAuthCubit.startBiometricAuth(
                            authenticationOptions:
                                (widget.isBiometricOnly ?? false)
                                    ? RootLocalAuthOptions.biometricOnlyOption
                                    : const AuthenticationOptions(),
                            displayTitle: widget.displayTitle);
                      },
                child: (widget.widgetBuilder != null)
                    ? _getWidgetFromBuilder()
                    : Icon(
                        (_localAuthCubit.isFaceIdOnly ?? false)
                            ? Icons.face
                            : Icons.fingerprint,
                        size: 30,
                        color: Colors.black,
                      ))
            : const SizedBox.shrink();
      },
    );
  }

  /// This will build the custom widget as expected by user.
  Widget _getWidgetFromBuilder() {
    Widget authWidget = widget.widgetBuilder!(
        context, _localAuthCubit.isFaceIdOnly ?? false, () {
      _localAuthCubit.startBiometricAuth(
          authenticationOptions: (widget.isBiometricOnly ?? false)
              ? RootLocalAuthOptions.biometricOnlyOption
              : const AuthenticationOptions(),
          displayTitle: widget.displayTitle);
    });

    return RepaintBoundary(
      child: authWidget,
    );
  }
}
