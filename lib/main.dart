import 'package:bonecole/screens/auth/login_page.dart';
import 'package:bonecole/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupLocator();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // routes: appRoutes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        fontFamily: "Nunito",
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      // home: BookDetailScreen(
      //   book: BookModel(
      //       category: "category",
      //       categoryId: "categoryId",
      //       instructor: "instructor",
      //       subLevel: "subLevel",
      //       title: "title",
      //       uid: "uid",
      //       body: "body"),
      //   curriculums: const [],
      // ),
      routes: appRoutes,
    );
  }
}
