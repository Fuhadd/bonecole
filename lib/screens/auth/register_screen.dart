import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/custom_colors.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_textfield.dart';
import 'auth_view_model.dart';
import 'login_page.dart';

class RegisterPage extends StatefulHookConsumerWidget {
  const RegisterPage({super.key});
  static const routeName = '/register_page';

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  // text editing controllers
  final _formKey = GlobalKey<FormBuilderState>();
  bool obscureText = true;

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    final registerVM = ref.watch(authProvider);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).padding.top +
                  MediaQuery.of(context).padding.bottom),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        SvgPicture.asset(
                          "assets/icons/book_read.svg",
                          height: 100,
                          // width: double.infinity,
                        ),
                        // logo
                        // const Icon(
                        //   Icons.lock,
                        //   size: 50,
                        //   color: CustomColors.mainColor,
                        // ),

                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Already have an account?',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, LoginPage.routeName);
                                },
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: CustomColors.mainColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // welcome back, you've been missed!
                        Text(
                          'Welcome back you\'ve been missed!',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 25),

                        // username textfield
                        customTextField(
                          "firstName",
                          hintText: 'FirstName',
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.minLength(3,
                                  errorText:
                                      'A valid first name should be greater than 4 characters '),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),
                        customTextField(
                          "lastName",
                          hintText: 'Lastname',
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.minLength(3,
                                  errorText:
                                      'A valid last name should be greater than 4 characters '),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        customTextField(
                          "email",
                          hintText: 'Email',
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.email(
                                  errorText: 'Provided email not valid '),
                              FormBuilderValidators.required(
                                  errorText: 'Email field cannot be empty '),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),
                        // customTextField(
                        //   "companyId",
                        //   hintText: 'Company Id - Optional',
                        // ),

                        const SizedBox(height: 10),
                        customTextField(
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
                        // forgot password?
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 25),

                        // sign in button
                        MyButton(
                          isLoading: registerVM.isLoading,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            bool? validate = _formKey.currentState?.validate();
                            print(validate);
                            if (validate == true) {
                              // String? companyId = _formKey
                              //     .currentState?.fields['companyId']?.value
                              //     .toString()
                              //     .trim();

                              // if (companyId!.isEmpty || companyId == "null") {
                              //   companyId = "0";
                              // }
                              _formKey.currentState?.save();

                              var email = _formKey
                                  .currentState?.fields['email']?.value
                                  .toString()
                                  .trim();
                              var firstName = _formKey
                                  .currentState?.fields['firstName']?.value
                                  .toString()
                                  .trim();
                              var lastName = _formKey
                                  .currentState?.fields['lastName']?.value
                                  .toString()
                                  .trim();
                              // var companyid = int.parse(companyId);

                              var password = _formKey
                                  .currentState?.fields['password']?.value;
                              registerVM.signUp(
                                  email: email!,
                                  firstName: firstName!,
                                  lastName: lastName!,
                                  password: password,

                                  // email, password,firstName,lastName,companyId
                                  context: context);
                            }
                          },
                          color: CustomColors.mainColor,
                        ),

                        // not a member? register now
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
