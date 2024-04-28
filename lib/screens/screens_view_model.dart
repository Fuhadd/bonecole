import 'package:bonecole/models/course_pack_result_model.dart';
import 'package:bonecole/models/teachers_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/book_model.dart';
import '../models/course_model.dart';
import '../view_model/base_change_notifier.dart';

class ScreenViewModel extends BaseChangeNotifier {
  Future<CoursePackResultModel> getBooksByCourse(String courseId) async {
    try {
      final courses = await userRepository.getBooksByCourse(courseId);
      final coursePacks = await userRepository.getCoursePacksByCourse(courseId);

      return CoursePackResultModel(courses: courses, coursePacks: coursePacks);
    } catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
    }
    Fluttertoast.showToast(msg: "Error getting dashboard Data!");
    throw ("Error getting dashboard Data!");
  }

  Future<List<BookModel>> getBooksFromList(List<String> courseIdList) async {
    try {
      final courses = await userRepository.getBooksFromCourseList(courseIdList);
      // final coursePacks = await userRepository.getCoursePacksByCourse(courseId);
      return courses;

      // return CoursePackResultModel(courses: courses, coursePacks: coursePacks);
    } catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
    }
    Fluttertoast.showToast(msg: "Error getting dashboard Data!");
    throw ("Error getting dashboard Data!");
  }

  // Future<List<BookModel>> getBooksByCourse(String courseId) async {
  //   try {
  //     final res = await userRepository.getBooksByCourse(courseId);
  //     return res;
  //   } catch (e, stacktrace) {
  //     log(e.toString());
  //     log(stacktrace.toString());
  //   }
  //   throw ("Error getting dashboard Data!");
  // }

  Future<List<BookModel>> getAllBooks() async {
    try {
      final res = await userRepository.getAllBooks();
      return res;
    } catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
    }
    throw ("Error getting dashboard Data!");
  }

  Future<List<CurriculumResultModel>> getAllCurriculumsBySection(
      String sectionId) async {
    try {
      final res = await userRepository.getAllCurriculumsBySection(sectionId);
      return res;
    } catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
    }
    throw ("Error getting dashboard Data!");
  }

  Future<TeacherModel?> getAllTeachersFromName(
      String firstName, String lastName) async {
    try {
      final res =
          await userRepository.getAllTeachersFromName(firstName, lastName);
      return res;
    } catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
    }
    throw ("Error getting dashboard Data!");
  }

  Future<List<CourseModel>> getAllCurriculums() async {
    try {
      final res = await userRepository.getAllCurriculums();
      return res;
    } catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
    }
    throw ("Error getting dashboard Data!");
  }

  Future<List<DownloadedCourseModel>> getAllDownloadedCurriculums() async {
    try {
      final res = await userRepository.getAllDownloadedCurriculums();
      return res;
    } catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
    }
    throw ("Error getting dashboard Data!");
  }
}
