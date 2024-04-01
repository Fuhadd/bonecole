import 'package:bonecole/screens/auth/second_register_screen.dart';
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
  List<String> classOptions = ["6eme Annee", "10eme Annee", "Terminales"];
  String selectedClassOption = "";

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    final registerVM = ref.watch(authProvider);
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
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
                        const SizedBox(height: 20),
                        const Text(
                          'Bienvenue à Bonécole!',
                          style: TextStyle(
                              color: CustomColors.blackColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w800),
                        ),
                        verticalSpacer(10),
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

                        // username textfield
                        customTextField2(
                          "fullName",
                          hintText: 'nom et prénom',
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.minLength(3,
                                  errorText:
                                      'A valid name should be greater than 4 characters '),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        customTextField2(
                          "email",
                          hintText: 'adresse e-mail',
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
                          "phone",
                          hintText: 'Numero de Telephone',
                          initialValue: "224",
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.minLength(3,
                                  errorText:
                                      'A valid last name should be greater than 4 characters '),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.15),
                                  width: 1.0),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text(
                                    "Classe et option",
                                    style: TextStyle(
                                      color: CustomColors.mainColor
                                          .withOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  isExpanded: true,
                                  elevation: 0,
                                  value: ref
                                              .watch(roomNameProvider.notifier)
                                              .state ==
                                          null
                                      ? null
                                      : ref
                                          .watch(roomNameProvider.notifier)
                                          .state!,
                                  //  ??
                                  //     snapshot.data![0].propertyName,
                                  items: classOptions.map((classOption) {
                                    return DropdownMenuItem(
                                      value: classOption,
                                      child: Text(
                                        classOption,
                                        style: const TextStyle(
                                            color: CustomColors.mainColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    );
                                  }).toList(),

                                  onChanged: (value) {
                                    // ref
                                    //     .read(propertyNameProvider.notifier)
                                    //     .state = value!.propertyName;
                                    ref.read(roomNameProvider.notifier).state =
                                        value;
                                    setState(() {
                                      selectedClassOption = value ?? '';
                                    });

                                    print("object");
                                    print(ref.watch(roomNameProvider));
                                    // print(propertyName);
                                    // print(propertyState);
                                    // setState(() {
                                    //   ref
                                    //       .read(
                                    //           propertyNameProvider.notifier)
                                    //       .state = value!.propertyName;
                                    //   ref
                                    //       .read(propertyProvider.notifier)
                                    //       .state = value;
                                    //   // propertyName = value!;
                                    //   // _selectedProperty = value!;
                                    // });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                        // customTextField(
                        //   "companyId",
                        //   hintText: 'Company Id - Optional',
                        // ),

                        // const SizedBox(height: 10),
                        const SizedBox(height: 20),
                        customTextField2(
                          "password",
                          hintText: 'mot de passe',
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
                        // const SizedBox(height: 15),
                        // forgot password?
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
                          isLoading: registerVM.isLoading,
                          title: "S'INSCRIRE",
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            bool? validate = _formKey.currentState?.validate();
                            print(validate);
                            if (validate == true &&
                                selectedClassOption.isNotEmpty) {
                              // String? companyId = _formKey
                              //     .currentState?.fields['companyId']?.value
                              //     .toString()
                              //     .trim();

                              // if (companyId!.isEmpty || companyId == "null") {
                              //   companyId = "0";
                              // }
                              _formKey.currentState?.save();
                              var fullName = _formKey
                                  .currentState?.fields['fullName']?.value
                                  .toString()
                                  .trim();

                              var email = _formKey
                                  .currentState?.fields['email']?.value
                                  .toString()
                                  .trim();

                              var telephone = _formKey
                                  .currentState?.fields['phone']?.value
                                  .toString()
                                  .trim();
                              // var companyid = int.parse(companyId);

                              var password = _formKey
                                  .currentState?.fields['password']?.value;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SecondRegisterPage(
                                    fullName: fullName!,
                                    email: email!,
                                    classOption: selectedClassOption,
                                    password: password,
                                    telephone: telephone!,
                                  ),
                                ),
                              );

                              // registerVM.signUp(
                              //     email: email!,
                              //     firstName: firstName!,
                              //     lastName: lastName!,
                              //     password: password,

                              //     // email, password,firstName,lastName,companyId
                              //     context: context);
                            }
                          },
                          color: CustomColors.blackColor,
                        ),
                        verticalSpacer(20),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginPage.routeName);
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
