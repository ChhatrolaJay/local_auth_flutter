//Meditab Software Inc. CONFIDENTIAL
//__________________
//
// [2024] Meditab Software Inc.
// All Rights Reserved.
//
//NOTICE:  All information contained herein is, and remains
//the property of Meditab Software Inc. and its suppliers,
//if any.  The intellectual and technical concepts contained
//herein are proprietary to Meditab Software Incorporated
//and its suppliers and may be covered by U.S. and Foreign Patents,
//patents in process, and are protected by trade secret or copyright law.
//Dissemination of this information or reproduction of this material
//is strictly forbidden unless prior written permission is obtained
//from Meditab Software Incorporated.
//
//File Name: main.dart
//
//@author Jay Chhatrola (jayc@meditab.com) Meditab Software Inc.
//@version 1.0.0
//@since 15/03/24 3:02 PM
//

import 'package:flutter/material.dart';
import 'package:local_auth_flutter/local_auth_cubit.dart';
import 'package:local_auth_flutter/local_auth_flutter.dart';

class GenericAuthExample extends StatefulWidget {
  const GenericAuthExample({super.key});

  @override
  State<GenericAuthExample> createState() => _GenericAuthExampleState();
}

class _GenericAuthExampleState extends State<GenericAuthExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generic Biometric demo'),
      ),
      body: Center(
        child: LocalAuthWidget(
          localAuthListener: (context, state) {
            if (state is BiometricAuthenticationSuccessState) {
              print("push to next screen");
            } else if (state is BiometricNotSupportedState) {
              print("no biometrics available");
            } else if (state is BiometricAuthenticationFailedState) {
              print("failed biometrics");
            }
          },
          widgetBuilder: (context, isFaceId, func) {
            return TextButton(
              onPressed: () {
                func();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Authenticate"),
                  Icon(
                    (isFaceId) ? Icons.face : Icons.fingerprint,
                    size: 36,
                    color: Colors.black,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
