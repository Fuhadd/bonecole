import 'package:bonecole/screens/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/custom_colors.dart';
import '../../utils/spacers.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_textfield.dart';
import 'auth_view_model.dart';

class LoginPage extends StatefulHookConsumerWidget {
  const LoginPage({super.key});
  static const routeName = '/login_screen';

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  // text editing controllers
  final _formKey = GlobalKey<FormBuilderState>();
  bool obscureText = true;

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    final loginVM = ref.watch(authProvider);
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).padding.top +
                    MediaQuery.of(context).padding.bottom),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const SizedBox(height: 50),

                        const SizedBox(height: 20),
                        const Text(
                          'Bienvenue à Bonécole!',
                          style: TextStyle(
                              color: CustomColors.blackColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w800),
                        ),
                        verticalSpacer(30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 150,
                                width: ((MediaQuery.of(context).size.width) -
                                        180) /
                                    2,
                                decoration: const BoxDecoration(
                                  color: CustomColors.mainColor,
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/boy_yellow_bg.png',
                                      ),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(100),
                                    topRight: Radius.circular(100),
                                    bottomLeft: Radius.circular(100),
                                  ),
                                ),
                              ),
                              horizontalSpacer(20),
                              Column(
                                children: [
                                  Container(
                                    height: 80,
                                    width:
                                        ((MediaQuery.of(context).size.width) -
                                                100) /
                                            2,
                                    decoration: const BoxDecoration(
                                      color: CustomColors.mainColor,
                                      image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/girl_red_bg.png',
                                          ),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        topRight: Radius.circular(100),
                                        bottomRight: Radius.circular(100),
                                      ),
                                    ),
                                  ),
                                  verticalSpacer(10),
                                  Container(
                                    height: 80,
                                    width:
                                        ((MediaQuery.of(context).size.width) -
                                                100) /
                                            2,
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                      image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/boy_blue_bg.png',
                                          ),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        bottomRight: Radius.circular(100),
                                        bottomLeft: Radius.circular(100),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 50),

                        const SizedBox(height: 25),

                        // username textfield

                        customTextField2(
                          "email",
                          hintText: 'Email address',
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.email(
                                  errorText: 'Provided email not valid '),
                              FormBuilderValidators.required(
                                  errorText: 'Email field cannot be empty '),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                        customTextField2(
                          "password",
                          hintText: 'Password',
                          obscureText: obscureText,
                          suffixIcon: obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.minLength(6,
                                errorText:
                                    'Good passwords are greater than 6 characters'),
                            FormBuilderValidators.required(
                                errorText: 'Password field cannot be empty '),
                          ]),
                          onSuffixTap: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        ),
                        const SizedBox(height: 15),

                        // // forgot password?
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: [
                        //       Text(
                        //         'Forgot Password?',
                        //         style: TextStyle(color: Colors.grey[600]),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        const SizedBox(height: 25),

                        // sign in button
                        MyButton(
                          isLoading: loginVM.isLoading,
                          title: "Sign In",
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            bool? validate = _formKey.currentState?.validate();
                            print(validate);
                            if (validate == true) {
                              _formKey.currentState?.save();

                              var email = _formKey
                                  .currentState?.fields['email']?.value
                                  .toString()
                                  .trim();
                              var password = _formKey
                                  .currentState?.fields['password']?.value;
                              loginVM.signIn(email, password, context: context);
                            }
                          },
                          color: CustomColors.mainColor,
                        ),
                        verticalSpacer(30),
                        // not a member? register now
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, RegisterPage.routeName);
                            },
                            child: const Text.rich(
                              TextSpan(
                                text: ' Vous avez déjà un compte? ',
                                style: TextStyle(
                                  color: CustomColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Se connecter',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14,
                                        decoration: TextDecoration.underline),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
