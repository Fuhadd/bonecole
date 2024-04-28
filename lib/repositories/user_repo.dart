// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

import 'dart:io';

import 'package:bonecole/models/chapters_model.dart';
import 'package:bonecole/models/course_model.dart';
import 'package:bonecole/models/course_packs.dart';
import 'package:bonecole/models/teachers_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../../models/app_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/book_model.dart';
import '../utils/directory_path.dart';
import '../view_model/local_cache/local_cache.dart';

abstract class UserRepository {
  Future<User?> createUserWithEmail(String email, String password);
  Future<User?> loginWithEmail(String email, String password);
  Future isUserSignedIn();
  Future logOut();
  Future resetPassword(String email);
  Future<List<BookModel>> getBooksFromCourseList(List<String> courseIdList);
  Future<AppUser> fetchCurrentUser();
  Future<TeacherModel?> getAllTeachersFromName(
      String firstName, String lastName);
  Future<String?> saveUserCredentials({
    required String email,
    required String password,
    required String fullName,
    required String telephone,
    required String classOption,
    required String facebook,
    required String affiliate,
    required String schoolOrigin,
    required String pvExamen,
    required String imageUrl,
    required DateTime accountCreated,
  });
  Future<void> updateUserCredentials({
    required String email,
    required String fullName,
    required String telephone,
    required String classOption,
    required String facebook,
    required String affiliate,
    required String schoolOrigin,
    required String pvExamen,
    required String imageUrl,
  });
  Future<AppUser?> getUsersCredentials();
  Future<List<BookModel>> getBooksByCourse(String courseId);
  Future<List<CoursePackModel>> getCoursePacksByCourse(String categoryId);
  Future<List<BookModel>> getAllBooks();
  Future<List<CurriculumResultModel>> getAllCurriculumsBySection(
      String sectionId);
  Future<List<CourseModel>> getAllCurriculums();
  Future<List<DownloadedCourseModel>> getAllDownloadedCurriculums();
  Future<List<TeacherModel>> getAllTeachers();
}

class UserRepositoryImpl implements UserRepository {
  late LocalCache cache;

  UserRepositoryImpl({
    required this.cache,
  }) : super();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference firebaseFirestore =
      FirebaseFirestore.instance.collection('users');
  CollectionReference sectionFirebaseFirestore =
      FirebaseFirestore.instance.collection('sections');
  CollectionReference packFirebaseFirestore =
      FirebaseFirestore.instance.collection('packs');
  CollectionReference chapterFirebaseFirestore =
      FirebaseFirestore.instance.collection('chapters');
  CollectionReference courseFirebaseFirestore =
      FirebaseFirestore.instance.collection('boneCourses');
  CollectionReference teacherFirebaseFirestore =
      FirebaseFirestore.instance.collection('teachers');

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
  Future<String?> saveUserCredentials({
    required String email,
    required String password,
    required String fullName,
    required String telephone,
    required String classOption,
    required String facebook,
    required String affiliate,
    required String schoolOrigin,
    required String pvExamen,
    required String imageUrl,
    required DateTime accountCreated,
  }) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    await firebaseFirestore.doc(uid.toString()).set(
        imageUrl.isEmpty
            ? {
                "email": email,
                "password": password,
                "fullName": fullName,
                "telephone": telephone,
                "classOption": classOption,
                "facebook": facebook,
                "affiliate": affiliate,
                "schoolOrigin": schoolOrigin,
                "pvExamen": pvExamen,
                "accountCreated": accountCreated,
              }
            : {
                "email": email,
                "password": password,
                "fullName": fullName,
                "telephone": telephone,
                "classOption": classOption,
                "facebook": facebook,
                "affiliate": affiliate,
                "schoolOrigin": schoolOrigin,
                "pvExamen": pvExamen,
                "accountCreated": accountCreated,
                "imageUrl": imageUrl,
              },
        SetOptions(
          merge: true,
        ));
    return uid;
  }

  @override
  Future<void> updateUserCredentials({
    required String email,
    required String fullName,
    required String telephone,
    required String classOption,
    required String facebook,
    required String affiliate,
    required String schoolOrigin,
    required String pvExamen,
    required String imageUrl,
  }) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    await firebaseFirestore.doc(uid.toString()).update(
          imageUrl.isEmpty
              ? {
                  "email": email,
                  "fullName": fullName,
                  "telephone": telephone,
                  "classOption": classOption,
                  "facebook": facebook,
                  "affiliate": affiliate,
                  "schoolOrigin": schoolOrigin,
                  "pvExamen": pvExamen,
                }
              : {
                  "email": email,
                  "fullName": fullName,
                  "telephone": telephone,
                  "classOption": classOption,
                  "facebook": facebook,
                  "affiliate": affiliate,
                  "schoolOrigin": schoolOrigin,
                  "pvExamen": pvExamen,
                  "imageUrl": imageUrl,
                },
        );
  }

  @override
  Future<AppUser?> getUsersCredentials() async {
    try {
      String uid = firebaseAuth.currentUser!.uid;

      final appUser = firebaseFirestore.doc(uid);
      final snapshot = await appUser.get();

      if (snapshot.exists) {
        return AppUser.fromJson(snapshot.data());
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
  Future<List<BookModel>> getBooksFromCourseList(
      List<String> courseIdList) async {
    List<BookModel> books = [];
    String? uid = firebaseAuth.currentUser?.uid.toString();
    QuerySnapshot? querySnapshot;
    for (var courseId in courseIdList) {
      querySnapshot = await sectionFirebaseFirestore
          .where('uid', isEqualTo: courseId)
          .get();

      for (var book in querySnapshot.docs) {
        var result = BookModel.fromJson(book.data());
        books.add(result);
      }
    }

    // if (querySnapshot != null) {
    //   for (var book in querySnapshot.docs) {
    //     var result = BookModel.fromJson(book.data());
    //     books.add(result);
    //   }
    // }

    return books;
  }

  @override
  Future<List<CoursePackModel>> getCoursePacksByCourse(
      String categoryId) async {
    List<CoursePackModel> coursePacks = [];
    String? uid = firebaseAuth.currentUser?.uid.toString();
    final QuerySnapshot querySnapshot = await packFirebaseFirestore
        .where('categoryId', isEqualTo: categoryId)
        .get();

    for (var coursePack in querySnapshot.docs) {
      var result = CoursePackModel.fromJson(coursePack.data());
      coursePacks.add(result);
    }

    return coursePacks;
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
    try {
      List<CurriculumResultModel> curriculumResults = [];
      List<CourseModel> courseList = [];
      String? uid = firebaseAuth.currentUser?.uid.toString();
      final QuerySnapshot querySnapshot = await chapterFirebaseFirestore
          .where('sectionId', isEqualTo: sectionId)
          // .where('createdBy', isNotEqualTo: uid)
          .orderBy('title', descending: false)
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
            .orderBy('title', descending: false)
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
    } catch (e) {
      print(e.toString());
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<List<CourseModel>> getAllCurriculums() async {
    List<CourseModel> courseList = [];
    String? uid = firebaseAuth.currentUser?.uid.toString();
    final QuerySnapshot querySnapshot = await courseFirebaseFirestore
        // .where('createdBy', isNotEqualTo: uid)
        // .orderBy('createdAt', descending: true)
        .orderBy('title', descending: false)
        .get();

    for (var course in querySnapshot.docs) {
      var result = CourseModel.fromJson(course.data());

      courseList.add(result);
    }

    return courseList;
  }

  @override
  Future<List<DownloadedCourseModel>> getAllDownloadedCurriculums() async {
    // List<CourseModel> courseList = [];
    List<DownloadedCourseModel> downloadedCourseList = [];
    String? uid = firebaseAuth.currentUser?.uid.toString();
    final QuerySnapshot querySnapshot = await courseFirebaseFirestore
        // .where('createdBy', isNotEqualTo: uid)
        // .orderBy('createdAt', descending: true)
        .orderBy('title', descending: false)
        .get();

    for (var course in querySnapshot.docs) {
      var result = CourseModel.fromJson(course.data());

      var getPathFile = DirectoryPath();
      var storePath = await getPathFile.getPath();
      String filePath = '$storePath/${result.uid}';
      bool fileExistCheck = await File("$filePath.mp3").exists() ||
          await File("$filePath.mp4").exists();
      if (fileExistCheck) {
        // courseList.add(result);
        downloadedCourseList.add(await File("$filePath.mp3").exists()
            ? DownloadedCourseModel(
                course: result, downloadedPath: "$filePath.mp3")
            : DownloadedCourseModel(
                course: result, downloadedPath: "$filePath.mp4"));
      }
    }

    return downloadedCourseList;
  }

  @override
  Future<List<TeacherModel>> getAllTeachers() async {
    List<TeacherModel> teachers = [];
    final QuerySnapshot querySnapshot =
        await teacherFirebaseFirestore.limit(5).get();

    for (var teacher in querySnapshot.docs) {
      var result = TeacherModel.fromJson(teacher.data());
      teachers.add(result);
    }

    return teachers;
  }

  @override
  Future<TeacherModel?> getAllTeachersFromName(
      String firstName, String lastName) async {
    final QuerySnapshot querySnapshot = await teacherFirebaseFirestore
        .where('firstName', isEqualTo: firstName)
        .where('lastName', isEqualTo: lastName)
        .get();
    if (querySnapshot.docs.isEmpty) {
      return null;
    }
    var teacher = querySnapshot.docs[0];
    var result = TeacherModel.fromJson(teacher.data());

    return result;
  }
}
