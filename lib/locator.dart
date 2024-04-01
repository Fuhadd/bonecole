import 'package:bonecole/repositories/firebase_storage_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'repositories/user_repo.dart';
import 'utils/navigator_handler.dart';
import 'view_model/local_cache/local_cache.dart';
import 'view_model/local_cache/local_cache_impl.dart';

GetIt locator = GetIt.instance;

///Registers dependencies
Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton(sharedPreferences);

  //Local storage

  // //Local storage
  locator.registerLazySingleton<NavigationHandler>(
    () => NavigationHandlerImpl(),
  );
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      cache: locator(),
    ),
  );

  locator.registerLazySingleton<FirebaseStorageRepository>(
    () => FirebaseStorageRepositoryImpl(
      cache: locator(),
    ),
  );

  locator.registerLazySingleton<LocalCache>(
    () => LocalCacheImpl(
      sharedPreferences: locator(),
    ),
  );
}
