import 'dart:io';

import 'package:bonecole/models/app_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/custom_colors.dart';
import '../../utils/spacers.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_textfield.dart';
import '../locator.dart';
import '../repositories/user_repo.dart';
import '../view_model/local_cache/local_cache.dart';
import '../widgets/article_title_widget.dart';
import '../widgets/end_drawer.dart';
import 'auth/auth_view_model.dart';
import 'auth/login_page.dart';

class ProfilePage extends StatefulHookConsumerWidget {
  const ProfilePage({super.key});
  static const routeName = '/profile_page';

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  // text editing controllers
  final _formKey = GlobalKey<FormBuilderState>();
  bool obscureText = true;
  List<String> classOptions = ["6eme Annee", "10eme Annee", "Terminales"];
  String selectedClassOption = locator<LocalCache>().getUserData().classOption;
  List<String> refer = [
    "Facebook",
    "Visite de Bonecole dans mon école",
    "Télé / Radio",
    "Affilié Bonecole",
    "À travers une connaissance",
    "Autres (veuillez préciser)",
  ];
  File? image;
  String? selectedRefer;
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
    final profileVM = ref.watch(authProvider);
    AppUser userData = locator<LocalCache>().getUserData();

    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: CustomColors.mainColor),
        centerTitle: false,
        title: SvgPicture.asset(
          "assets/icons/bonecole_icon.svg",
          height: 50,
        ),
        actions: [
          Builder(builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: SvgPicture.asset(
                  "assets/icons/menu_icon.svg",
                  height: 14,
                ),
              ),
            );
          })
        ],
      ),
      endDrawer: const Drawer(
        backgroundColor: Colors.black,
        child: EndDrawer(),
      ),
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

                        verticalSpacer(10),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: ArticleTitle(
                            title: "MON PROFIL",
                          ),
                        ),

                        const SizedBox(height: 20),

                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              height: 145,
                              width: 145,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      CustomColors.blackColor.withOpacity(0.5),
                                ),
                              ),
                            ),
                            _loading
                                ? Container(
                                    height: 140,
                                    width: 140,
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : image != null
                                    ? Container(
                                        height: 140,
                                        width: 140,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          image: DecorationImage(
                                            image: FileImage(image!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : userData.imageUrl.isNotEmpty
                                        ? Container(
                                            height: 140,
                                            width: 140,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    userData.imageUrl),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            height: 140,
                                            width: 140,
                                            decoration: const BoxDecoration(
                                              color: Colors.grey,
                                            ),
                                            child: const Icon(
                                              Icons.person,
                                              size: 40,
                                              color: CustomColors.whiteColor,
                                            ),
                                          ),
                          ],
                        ),
                        verticalSpacer(20),
                        MyButton(
                          isLoading: profileVM.isLoading,
                          title: "TÉLÉCHARGER",
                          onTap: () async {
                            var imagePath = await onPickImage();
                            setState(() {
                              _loading = false;
                            });
                            if (imagePath == null) {
                              Fluttertoast.showToast(
                                  msg: "Failed to pick an Image");
                            } else {
                              final tempimage = File(imagePath.toString());
                              setState(() {
                                image = tempimage;
                              });
                            }
                          },
                          color: CustomColors.blackColor,
                          width: 160,
                          height: 45,
                        ),

                        // d
                        verticalSpacer(20),
                        // username textfield
                        customTextField2(
                          "fullName",
                          hintText: 'NOM COMPLET',
                          initialValue: userData.fullName,
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
                          hintText: 'EMAIL',
                          initialValue: userData.email,
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
                                  value: selectedClassOption.isEmpty
                                      ? null
                                      : selectedClassOption,
                                  //  ?? null
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
                                    // ref.read(roomNameProvider.notifier).state =
                                    //     value;
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

                        const SizedBox(height: 20),
                        customTextField2(
                          "phone",
                          hintText: 'Numero de Telephone',
                          initialValue: userData.telephone,
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.minLength(3,
                                  errorText:
                                      'A valid last name should be greater than 4 characters '),
                            ],
                          ),
                        ),

                        // customTextField(
                        //   "companyId",
                        //   hintText: 'Company Id - Optional',
                        // ),

                        // const SizedBox(height: 10),
                        const SizedBox(height: 35),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: const [
                              Text(
                                '(facultatif)',
                                style: TextStyle(
                                  color: CustomColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        customTextField2(
                          "facebook",
                          hintText: 'Facebook',
                          initialValue: userData.facebook,
                        ),

                        const SizedBox(height: 20),
                        customTextField2(
                          "affiliate",
                          initialValue: userData.affiliate,
                          hintText: 'Identifiant Affilié',
                        ),

                        const SizedBox(height: 20),
                        customTextField2(
                          "schoolOrigin",
                          initialValue: userData.schoolOrigin,
                          hintText: "Ecole d'origine",
                        ),

                        const SizedBox(height: 20),
                        customTextField2(
                          "pvExamen",
                          initialValue: userData.pvExamen,
                          hintText: 'PV examen',
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
                        const SizedBox(height: 35),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            'Comment avez vous découvert Bonecole la première fois ?',
                            style: TextStyle(
                              color: CustomColors.blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
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
                                    "Comment avez vous découvert Bonecole la première fois ?",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: CustomColors.mainColor
                                          .withOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  isExpanded: true,
                                  elevation: 0,
                                  value: selectedRefer,
                                  //  ??
                                  //     snapshot.data![0].propertyName,
                                  items: refer.map((refer) {
                                    return DropdownMenuItem(
                                      value: refer,
                                      child: Text(
                                        refer,
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
                                      selectedRefer = value ?? '';
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

                        const SizedBox(height: 40),

                        // sign in button
                        MyButton(
                          isLoading: profileVM.isLoading,
                          title: "Sauvegarder Changement",
                          fontSize: 14,
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
                              profileVM.updateUserCredentials(
                                  image: image!,
                                  email: email!,
                                  fullName: fullName!,
                                  telephone: telephone!,
                                  classOption: selectedClassOption,
                                  facebook: facebook!,
                                  affiliate: affiliate!,
                                  schoolOrigin: schoolOrigin!,
                                  pvExamen: pvExamen,
                                  context: context);
                            }
                          },
                          height: 45,
                          color: const Color.fromRGBO(240, 12, 68, 1),
                        ),
                        verticalSpacer(20),
                        MyButton(
                          // isLoading: profileVM.isLoading,
                          title: "Annuler",
                          fontSize: 14,
                          onTap: profileVM.isLoading
                              ? null
                              : () {
                                  FocusScope.of(context).unfocus();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfilePage()));
                                },
                          height: 45,
                          color: CustomColors.greyBgColor,
                        ),
                        verticalSpacer(50),

                        MyButton(
                          // isLoading: profileVM.isLoading,
                          title: "Se Déconnecter",
                          width: 150,
                          onTap: profileVM.isLoading
                              ? null
                              : () async {
                                  await locator<UserRepository>().logOut();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                },
                          height: 45,
                          color: CustomColors.whiteColor,
                          textColor: CustomColors.blackColor,
                          fontSize: 14,
                        ),
                        verticalSpacer(30),

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

class SecondProfilePage {}
