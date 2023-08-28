// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

import 'package:bonecole/models/chapters_model.dart';
import 'package:bonecole/models/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../../models/app_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/book_model.dart';
import '../models/user_data.dart';
import '../view_model/local_cache/local_cache.dart';

abstract class UserRepository {
  Future<User?> createUserWithEmail(String email, String password);
  Future<User?> loginWithEmail(String email, String password);
  Future isUserSignedIn();
  Future logOut();
  Future resetPassword(String email);
  Future<AppUser> fetchCurrentUser();
  Future<String?> saveUserCredentials(String email, String firstName,
      String lastName, String password, DateTime accountCreated);
  Future<UserDataModel?> getUsersCredentials();
  Future<List<BookModel>> getBooksByCourse(String courseId);
  Future<List<BookModel>> getAllBooks();
  Future<List<CurriculumResultModel>> getAllCurriculumsBySection(
      String sectionId);
}

class UserRepositoryImpl implements UserRepository {
  late LocalCache cache;

  UserRepositoryImpl({
    required this.cache,
  }) : super();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference firebaseFirestore =
      FirebaseFirestore.instance.collection('userData');
  CollectionReference sectionFirebaseFirestore =
      FirebaseFirestore.instance.collection('sections');
  CollectionReference chapterFirebaseFirestore =
      FirebaseFirestore.instance.collection('chapters');
  CollectionReference courseFirebaseFirestore =
      FirebaseFirestore.instance.collection('boneCourses');

  @override
  Future<User?> createUserWithEmail(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      if (user != null) {
        return user;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (error) {
      var message = error.message;
      switch (error.code) {
        case 'invalid-email:':
          message = 'Email is Invalid!';
          break;
        case 'email-already-in-use':
          message =
              'The email address already exists.Please proceed to login Screen ';
          break;
        case 'wrong-password':
          message = 'Invalid password. Please enter correct password.';
          break;
      }
      print(error.code);
      throw Exception(message);
    }
  }

  @override
  Future<AppUser> fetchCurrentUser() async {
    throw UnimplementedError();
    //  try {
    //   String? userJson = await SharedPreferenceHelper().getcurrentUser();
    //   AppUser currentUser = AppUser.fromJson(json.decode(userJson!));
    //   return currentUser;
    // } on PlatformException catch (error) {
    //   throw Exception(error);
    // }
  }

  @override
  Future isUserSignedIn() async {
    User? user = firebaseAuth.currentUser;
    return user != null && user.uid.isNotEmpty;
  }

  @override
  Future logOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<User?> loginWithEmail(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        return user;
      }
    } on FirebaseAuthException catch (error) {
      var message = error.message; // default message
      switch (error.code) {
        case 'user-disabled':
          message =
              'This user has been temporarily disabled, Contact Support for more information';
          break;
        case 'user-not-found':
          message =
              'The email address is not assocciated with a user.Try another Email up or Register with this email address ';
          break;
        case 'wrong-password':
          message = 'Invalid password. Please enter correct password.';
          break;
      }
      throw Exception(message);
    }
    return null;
  }

  @override
  Future resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on PlatformException catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<String?> saveUserCredentials(String email, String firstName,
      String lastName, String password, DateTime accountCreated) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    await firebaseFirestore.doc(uid.toString()).set(
        {
          'id': uid.toString(),
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'accountCreated': accountCreated,
          'timelog': [],
          'password': password,
        },
        SetOptions(
          merge: true,
        ));
    return uid;
  }

  @override
  Future<UserDataModel?> getUsersCredentials() async {
    try {
      String uid = firebaseAuth.currentUser!.uid;

      final appUser = firebaseFirestore.doc(uid);
      final snapshot = await appUser.get();

      if (snapshot.exists) {
        return UserDataModel.fromJson(snapshot.data());
      }
    } catch (error) {}
    return null;
  }

  @override
  Future<List<BookModel>> getBooksByCourse(String courseId) async {
    List<BookModel> books = [];
    String? uid = firebaseAuth.currentUser?.uid.toString();
    final QuerySnapshot querySnapshot = await sectionFirebaseFirestore
        .where('categoryId', isEqualTo: courseId)
        // .where('createdBy', isNotEqualTo: uid)
        // .orderBy('createdAt', descending: true)
        .get();

    // Extract the documents where the currentUserID is not present in the 'posts' array
    // final List<QueryDocumentSnapshot> posts = querySnapshot.docs
    //     .where((doc) => !(doc['members'] as List<dynamic>).contains(uid))
    //     .toList();

    for (var book in querySnapshot.docs) {
      var result = BookModel.fromJson(book.data());
      books.add(result);
    }

    return books;
  }

  @override
  Future<List<BookModel>> getAllBooks() async {
    List<BookModel> books = [];
    String? uid = firebaseAuth.currentUser?.uid.toString();
    final QuerySnapshot querySnapshot = await sectionFirebaseFirestore
        // .where('categoryId', isEqualTo: courseId)
        // .where('createdBy', isNotEqualTo: uid)
        // .orderBy('createdAt', descending: true)
        .get();

    // Extract the documents where the currentUserID is not present in the 'posts' array
    // final List<QueryDocumentSnapshot> posts = querySnapshot.docs
    //     .where((doc) => !(doc['members'] as List<dynamic>).contains(uid))
    //     .toList();

    for (var book in querySnapshot.docs) {
      var result = BookModel.fromJson(book.data());
      books.add(result);
    }

    return books;
  }

  @override
  Future<List<CurriculumResultModel>> getAllCurriculumsBySection(
      String sectionId) async {
    List<CurriculumResultModel> curriculumResults = [];
    List<CourseModel> courseList = [];
    String? uid = firebaseAuth.currentUser?.uid.toString();
    final QuerySnapshot querySnapshot = await chapterFirebaseFirestore
        .where('sectionId', isEqualTo: sectionId)
        // .where('createdBy', isNotEqualTo: uid)
        // .orderBy('createdAt', descending: true)
        .get();

    // Extract the documents where the currentUserID is not present in the 'posts' array
    // final List<QueryDocumentSnapshot> posts = querySnapshot.docs
    //     .where((doc) => !(doc['members'] as List<dynamic>).contains(uid))
    //     .toList();

    for (var chapter in querySnapshot.docs) {
      courseList = [];
      var result = ChaptersModel.fromJson(chapter.data());
      final QuerySnapshot querySnapshot1 = await courseFirebaseFirestore
          .where('chapterId', isEqualTo: result.uid)
          // .where('createdBy', isNotEqualTo: uid)
          // .orderBy('createdAt', descending: true)
          .get();
      for (var course in querySnapshot1.docs) {
        var newResult = CourseModel.fromJson(course.data());
        print(newResult);

        courseList.add(newResult);

        // books.add(result);
      }
      var data = CurriculumResultModel(chapter: result, courses: courseList);

      curriculumResults.add(data);

      // books.add(result);
    }

    return curriculumResults;
  }
}
