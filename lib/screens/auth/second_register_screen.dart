import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/custom_colors.dart';
import '../../utils/spacers.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_textfield.dart';
import 'auth_view_model.dart';
import 'login_page.dart';

class SecondRegisterPage extends StatefulHookConsumerWidget {
  final String fullName, telephone, email, classOption, password;
  const SecondRegisterPage({
    super.key,
    required this.fullName,
    required this.telephone,
    required this.email,
    required this.classOption,
    required this.password,
  });
  static const routeName = '/second_register_page';

  @override
  ConsumerState<SecondRegisterPage> createState() => _SecondRegisterPageState();
}

class _SecondRegisterPageState extends ConsumerState<SecondRegisterPage> {
  // text editing controllers
  final _formKey = GlobalKey<FormBuilderState>();
  File? image;
  bool _loading = false;

  // sign user in method
  void signUserIn() {}

  Future<String?> onPickImage() async {
    setState(() {
      _loading = true;
    });
    try {
      final imagePicked =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imagePicked != null) {
        return imagePicked.path;
      } else {
        return null;
      }
    } catch (e) {
      print("this is it --->");
      print(e.toString());
    }
    return null;
  }

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
                        Row(
                          children: [
                            SizedBox(
                                width: 140,
                                child: MyButton(onTap: () {}, title: "Back")),
                          ],
                        ),
                        verticalSpacer(20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: const [
                              Text(
                                'INSCRIPTION 2',
                                style: TextStyle(
                                    color: CustomColors.blackColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Divider(
                            color: CustomColors.mainColor,
                          ),
                        ),
                        verticalSpacer(10),
                        const Text(
                          "image de profil",
                          style: TextStyle(
                            color: CustomColors.mainColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        verticalSpacer(5),
                        image == null
                            ? GestureDetector(
                                onTap: () async {
                                  var imagePath = await onPickImage();
                                  setState(() {
                                    _loading = false;
                                  });
                                  if (imagePath == null) {
                                    Fluttertoast.showToast(
                                        msg: "Failed to pick an Image");
                                  } else {
                                    final tempimage =
                                        File(imagePath.toString());
                                    setState(() {
                                      image = tempimage;
                                    });
                                  }
                                },
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.85),
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.cloud_upload_outlined,
                                          size: 40,
                                        ),
                                        verticalSpacer(10),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Text(
                                            "Parcourir les fichiers à télécharger",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: CustomColors.mainColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.85),
                                      width: 1.0),
                                  borderRadius: BorderRadius.circular(3),
                                  image: DecorationImage(
                                    image: FileImage(image!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      image = null;
                                    });
                                  },
                                  child: const Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      Icons.delete,
                                      size: 25,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),

                        const SizedBox(height: 50),

                        // username textfield
                        customTextField2(
                          "facebook",
                          hintText: 'Facebook',
                        ),

                        const SizedBox(height: 20),
                        customTextField2(
                          "affiliate",
                          hintText: 'Identifiant Affilié',
                        ),

                        const SizedBox(height: 20),
                        customTextField2(
                          "schoolOrigin",
                          hintText: "Ecole d'origine",
                        ),

                        const SizedBox(height: 20),
                        customTextField2(
                          "pvExamen",
                          hintText: 'PV examen',
                        ),

                        const SizedBox(height: 25),

                        // sign in button
                        MyButton(
                          isLoading: registerVM.isLoading,
                          title: "SOUMETTRE",
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            bool? validate = _formKey.currentState?.validate();
                            print(validate);
                            if (validate == true) {
                              _formKey.currentState?.save();
                              var facebook = _formKey
                                  .currentState?.fields['facebook']?.value
                                  .toString()
                                  .trim();

                              var affiliate = _formKey
                                  .currentState?.fields['affiliate']?.value
                                  .toString()
                                  .trim();

                              var schoolOrigin = _formKey
                                  .currentState?.fields['schoolOrigin']?.value
                                  .toString()
                                  .trim();
                              // var companyid = int.parse(companyId);

                              var pvExamen = _formKey
                                  .currentState?.fields['pvExamen']?.value;

                              registerVM.signUp(
                                  fullName: widget.fullName,
                                  telephone: widget.telephone,
                                  email: widget.email,
                                  classOption: widget.classOption,
                                  facebook: facebook!,
                                  affiliate: affiliate!,
                                  schoolOrigin: schoolOrigin!,
                                  pvExamen: pvExamen!,
                                  password: widget.password,
                                  image: image,

                                  // email, password,firstName,lastName,companyId
                                  context: context);
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
