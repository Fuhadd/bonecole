import '../models/book_model.dart';
import '../models/course_model.dart';
import '../view_model/base_change_notifier.dart';

class ScreenViewModel extends BaseChangeNotifier {
  Future<List<BookModel>> getBooksByCourse(String courseId) async {
    try {
      final res = await userRepository.getBooksByCourse(courseId);
      return res;
    } catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
    }
    throw ("Error getting dashboard Data!");
  }

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
}
