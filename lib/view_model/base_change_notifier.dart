import 'package:bonecole/repositories/firebase_storage_repository.dart';
import 'package:flutter/foundation.dart';
import '../locator.dart';
import '../repositories/user_repo.dart';
import '../utils/app_logger.dart';
import '../utils/navigator_handler.dart';
import 'local_cache/local_cache.dart';

class BaseChangeNotifier extends ChangeNotifier {
  late UserRepository userRepository;
  late FirebaseStorageRepository firebaseStorageRepository;
  late LocalCache localCache;
  late NavigationHandler navigationHandler;

  BaseChangeNotifier({
    UserRepository? userRepository,
    FirebaseStorageRepository? firebaseStorageRepository,
    LocalCache? localCache,
    NavigationHandler? navigationHandler,
  }) {
    this.userRepository = userRepository ?? locator();
    this.firebaseStorageRepository = firebaseStorageRepository ?? locator();
    this.localCache = localCache ?? locator();
    this.navigationHandler = navigationHandler ?? locator();
  }

  // ignore: prefer_final_fields
  bool _loading = false;

  bool get loading => _loading;
  void log(Object? e) {
    AppLogger.log("$e");
  }
}
