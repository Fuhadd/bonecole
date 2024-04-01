import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bonecole/screens/homescreen.dart';
import 'package:bonecole/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      required String fullName,
      required String telephone,
      required String classOption,
      required String facebook,
      required String affiliate,
      required String schoolOrigin,
      required String pvExamen,
      File? image,
      BuildContext? context}) async {
    try {
      isLoading = true;

      final user = await userRepository.createUserWithEmail(
        email,
        password,
      );

      if (user != null) {
        _email = email;

        String imageUrl = "";
        if (image != null) {
          try {
            imageUrl = await firebaseStorageRepository.uploadImage(image);
          } catch (e) {
            isLoading = false;
            throw (e.toString());
          }
        }

        var userId = await userRepository.saveUserCredentials(
            email: email,
            password: password,
            fullName: fullName,
            telephone: telephone,
            classOption: classOption,
            facebook: facebook,
            affiliate: affiliate,
            schoolOrigin: schoolOrigin,
            pvExamen: pvExamen,
            imageUrl: imageUrl,
            accountCreated: DateTime.now());

        if (userId != null) {
          AppUser user = AppUser(
            id: userId,
            email: email,
            password: password,
            fullName: fullName,
            telephone: telephone,
            classOption: classOption,
            facebook: facebook,
            affiliate: affiliate,
            schoolOrigin: schoolOrigin,
            imageUrl: imageUrl,
            pvExamen: pvExamen,
          );
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
      Fluttertoast.showToast(msg: e.toString());
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }

  Future<void> updateUserCredentials(
      {required String email,
      required String fullName,
      required String telephone,
      required String classOption,
      required String facebook,
      required String affiliate,
      required String schoolOrigin,
      required String pvExamen,
      File? image,
      BuildContext? context}) async {
    try {
      isLoading = true;
      String imageUrl = "";

      _email = email;
      if (image != null) {
        try {
          imageUrl = await firebaseStorageRepository.uploadImage(image);
        } catch (e) {
          isLoading = false;
          throw (e.toString());
        }
      }

      await userRepository.updateUserCredentials(
        email: email,
        fullName: fullName,
        telephone: telephone,
        classOption: classOption,
        facebook: facebook,
        affiliate: affiliate,
        schoolOrigin: schoolOrigin,
        pvExamen: pvExamen,
        imageUrl: imageUrl,
      );

      var user = await userRepository.getUsersCredentials();

      if (user != null) {
        final userJson = json.encode(user.toJson());
        localCache.saveToLocalCache(
            key: ConstantString.userJson, value: userJson);
      }

      isLoading = false;
      Navigator.of(context!).pushReplacementNamed(
        ProfilePage.routeName,
      );

      // navigationHandler.pushNamed(
      //   ProfileScreen.routeName,
      // );
    } catch (e, stacktrace) {
      isLoading = false;
      Fluttertoast.showToast(msg: e.toString());
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
      Fluttertoast.showToast(msg: e.toString());
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }
}

final propertyNameProvider = StateProvider.autoDispose<String?>((ref) => null);
final roomNameProvider = StateProvider.autoDispose<String?>((ref) => null);
final isPlayingProvider = StateProvider.autoDispose<bool>((ref) => false);
final playerProvider = StateProvider<AudioPlayer>((ref) => AudioPlayer());

final durationProvider = StateProvider<Duration>((ref) => Duration.zero);
final positionProvider = StateProvider<Duration>((ref) => Duration.zero);
