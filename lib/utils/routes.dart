import 'package:bonecole/screens/auth/login_page.dart';
import 'package:bonecole/screens/auth/register_screen.dart';
import 'package:bonecole/screens/homescreen.dart';
import 'package:bonecole/screens/tous_page.dart';

import '../screens/profile_screen.dart';

var appRoutes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
  TousScreen.routeName: (context) => const TousScreen(),
  LoginPage.routeName: (context) => const LoginPage(),
  RegisterPage.routeName: (context) => const RegisterPage(),
  ProfilePage.routeName: (context) => const ProfilePage(),
  // TousScreen.routeName: (context) => const TousScreen(),
};
