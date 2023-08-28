import 'dart:async';
import 'dart:convert';

import 'package:bonecole/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/app_user_model.dart';
import '../../utils/custom_string.dart';
import '../../view_model/base_change_notifier.dart';

final authProvider = ChangeNotifierProvider.autoDispose<AuthViewModel>((ref) {
  return AuthViewModel.initWhoAmI();
});

class AuthViewModel extends BaseChangeNotifier {
  bool _isloading;

  String authorized = 'Not Authorized';

  AuthViewModel.initWhoAmI()
      : _isloading = false,
        _userId = "",
        _userName = "",
        _password = "",
        _email = "";
  AuthViewModel.profile()
      : _userId = "",
        _userName = "",
        _email = "",
        _password = "",
        _isloading = false;

  bool get isLoading => _isloading;
  String _email, _userId, _userName, _password = "";

  String get email => _email;
  String get password => _password;
  String get userId => _userId;

  String get userName => _userName;

  set isLoading(bool isloading) {
    _isloading = isloading;
    notifyListeners();
  }

  // FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<void> signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      BuildContext? context}) async {
    try {
      isLoading = true;

      final user = await userRepository.createUserWithEmail(
        email,
        password,
      );

      if (user != null) {
        _email = email;
        var userId = await userRepository.saveUserCredentials(
            email, firstName, lastName, password, DateTime.now());

        if (userId != null) {
          AppUser user = AppUser(id: userId, userName: userName, email: email);
          final userJson = json.encode(user.toJson());
          localCache.saveToLocalCache(
              key: ConstantString.userJson, value: userJson);
        }

        isLoading = false;
        Navigator.of(context!).pushReplacementNamed(
          HomeScreen.routeName,
        );

        // navigationHandler.pushNamed(
        //   ProfileScreen.routeName,
        // );
      } else {
        isLoading = false;

        // GenericDialog().showSimplePopup(
        //   type: InfoBoxType.warning,
        //   title: ConstantString.apiErrorResponseTitle,
        //   content: res.message,
        // );
      }
    } catch (e, stacktrace) {
      isLoading = false;
      ScaffoldMessenger.of(context!)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ));
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }

  Future<void> signIn(email, password, {BuildContext? context}) async {
    try {
      isLoading = true;
      final user = await userRepository.loginWithEmail(
        email,
        password,
      );

      if (user != null) {
        _email = email;
        var user = await userRepository.getUsersCredentials();

        if (user != null) {
          final userJson = json.encode(user.toJson());
          localCache.saveToLocalCache(
              key: ConstantString.userJson, value: userJson);
        }

        isLoading = false;

        // navigationHandler.pushNamed(
        //   ProfileScreen.routeName,
        // );
        Navigator.of(context!).pushReplacementNamed(
          HomeScreen.routeName,
        );
      } else {
        isLoading = false;
      }
    } catch (e, stacktrace) {
      isLoading = false;
      ScaffoldMessenger.of(context!)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ));
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }
}

final propertyNameProvider = StateProvider.autoDispose<String?>((ref) => null);
final roomNameProvider = StateProvider.autoDispose<String?>((ref) => null);
final loadingProvider = StateProvider.autoDispose<bool>((ref) => false);
