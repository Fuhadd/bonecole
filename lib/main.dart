import 'package:bonecole/screens/auth/login_page.dart';
import 'package:bonecole/screens/homescreen.dart';
import 'package:bonecole/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';
import 'locator.dart';
import 'screens/auth/auth_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupLocator();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulHookConsumerWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addObserver(MyAppLifecycleObserver(
    //   onCloseCallback: () async {
    //     await ref.watch(playerProvider).stop();
    //     // Your function to be executed when the app is closed
    //     // print('App is closed');
    //   },
    // ));
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        //Execute the code here when user come back the app.
        //In my case, I needed to show if user active or not,
        print(1);
        await ref.watch(playerProvider).stop();
        break;
      case AppLifecycleState.paused:
        //Execute the code the when user leave the app
        print(2);
        await ref.watch(playerProvider).stop();
        break;
      case AppLifecycleState.inactive:
        //Execute the code the when user leave the app
        print(3);
        await ref.watch(playerProvider).stop();
        break;
      // case AppLifecycleState.detached:
      //   //Execute the code the when user leave the app
      //   print(4);
      //   await ref.watch(playerProvider).stop();
      //   break;
      default:
        break;
    }
  }

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
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return const HomeScreen();
            } else {
              return const LoginPage();
            }
          }),
      // home: const LoginPage(),
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
