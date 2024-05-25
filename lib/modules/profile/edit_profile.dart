import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/core/resources/font_manager.dart';
import 'package:egytraveler/core/utils/color_manager.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/cubit.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/state.dart';
import 'package:egytraveler/modules/newPassword/new_password.dart';
import 'package:egytraveler/modules/profile/widget/text_from_filed_edit_profile.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isEdit = false;
  @override
  void initState() {
    var userData = HomeCubit.get(context).userData!.data!.user;
    fullNameController = TextEditingController(text: userData!.name);
    emailController = TextEditingController(text: userData.email);
    phoneController = TextEditingController(text: userData.phone);
    addressController = TextEditingController(text: userData.address);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          CherryToast.success(
            title: const Text('Edit Profile Successfully'),
            animationType: AnimationType.fromTop,
          ).show(context);
          HomeCubit.get(context).getUserData();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<HomeCubit>(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Edit Profile'.tr(context)),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 42,
                    ),
                    TextFromFiledEditProfile(
                        title: 'Full Name'.tr(context),
                        controller: fullNameController,
                        keyboardType: TextInputType.name,
                        onChanged: (v) {
                          if (fullNameController.text ==
                              HomeCubit.get(context)
                                  .userData!
                                  .data!
                                  .user!
                                  .name) {
                            setState(() {
                              isEdit = false;
                            });
                          } else {
                            setState(() {
                              isEdit = true;
                            });
                          }
                        },
                        hintText: ''),
                    const SizedBox(
                      height: 21,
                    ),
                    TextFromFiledEditProfile(
                        title: 'E-mail'.tr(context),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (v) {
                          if (emailController.text ==
                              HomeCubit.get(context)
                                  .userData!
                                  .data!
                                  .user!
                                  .email) {
                            setState(() {
                              isEdit = false;
                            });
                          } else {
                            setState(() {
                              isEdit = true;
                            });
                          }
                        },
                        hintText: ''),
                    const SizedBox(
                      height: 21,
                    ),
                    /*      TextFromFiledEditProfile(
                        title: 'Phone Number',
                        controller: phoneController,
                        onChanged: (v) {
                          if(phoneController.text == HomeCubit.get(context).userData!.data!.user!.phone) {
                            setState(() {
                              isEdit = false;
                            });
                          } else {
                            setState(() {
                              isEdit = true;
                            });
                          }
                        },
                        keyboardType: TextInputType.phone,
                        hintText: ''),
                    const SizedBox(
                      height: 21,
                    ),*/
                    TextFromFiledEditProfile(
                        title: 'Address'.tr(context),
                        controller: addressController,
                        onChanged: (v) {
                          if (addressController.text ==
                              HomeCubit.get(context)
                                  .userData!
                                  .data!
                                  .user!
                                  .address) {
                            setState(() {
                              isEdit = false;
                            });
                          } else {
                            setState(() {
                              isEdit = true;
                            });
                          }
                        },
                        keyboardType: TextInputType.streetAddress,
                        hintText: ''),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewPassword(),
                              ));
                        },
                        child: Text(
                          'Change password'.tr(context),
                          style: TextStyle(
                            color: ColorManager.kColorPrimary,
                            fontSize: 18,
                            fontFamily: FontConstants.fontFamilyRobotoFlex,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                            height: 0.08,
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Conditional.single(
                      context: context,
                      conditionBuilder: (BuildContext context) =>
                          state is! EditProfileLoading,
                      widgetBuilder: (context) {
                        return Container(
                          width: double.infinity,
                          height: 58,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: TextButton(
                            onPressed: isEdit == false
                                ? null
                                : () {
                                    var userData = HomeCubit.get(context)
                                        .userData!
                                        .data!
                                        .user;
                                    if (fullNameController.text ==
                                            userData!.name &&
                                        emailController.text ==
                                            userData.email &&
                                        phoneController.text ==
                                            userData.phone &&
                                        addressController.text ==
                                            userData.address) {
                                      CherryToast.info(
                                        title: const Text('No Changes'),
                                        animationType: AnimationType.fromTop,
                                      ).show(context);
                                    } else {
                                      cubit.updateProfile(
                                        username: fullNameController.text,
                                        address: addressController.text,
                                        phone: phoneController.text,
                                        avatar:
                                            HomeCubit.get(context).postImage,
                                      );
                                    }
                                  },
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // backgroundColor: ColorManager.primary,
                                backgroundColor: isEdit == false
                                    ? Colors.grey
                                    : const Color(0xff003441)),
                            child: Text(
                              "Save".tr(context),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                      fallbackBuilder: (BuildContext context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
