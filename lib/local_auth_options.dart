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
//File Name: local_auth_options
//
//@author Jay Chhatrola (jayc@meditab.com) Meditab Software Inc.
//@version 1.0.0
//@since 10/04/24 11:26 AM
//

part of 'local_auth_code.dart';

class RootLocalAuthOptions {
  static const AuthenticationOptions biometricOnlyOption =
      AuthenticationOptions(
    biometricOnly: true,
  );
}
