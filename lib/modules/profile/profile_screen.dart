import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/cubit.dart';
import 'package:egytraveler/core/layout/homeLayout/Presentation/Manager/HomeLayoutCubit/state.dart';
import 'package:egytraveler/model/usermodel/UserModel.dart';

import 'package:egytraveler/shared/components/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController currentPasswordController =
      TextEditingController();

  bool isChangePhoto = false;

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
            title: Text(state.successModel['status']),
            animationType: AnimationType.fromTop,
          ).show(context);
          HomeCubit.get(context).postImage = null;
          HomeCubit.get(context).userData =
              UserModel.fromJson(state.successModel);
        } else if (state is EditProfileError) {
          CherryToast.error(
                  title: const Text("Error"),
                  displayIcon: false,
                  description: Text(state.errorModel),
                  animationType: AnimationType.fromTop,
                  animationDuration: const Duration(milliseconds: 1000),
                  autoDismiss: true)
              .show(context);
        } else if (state is DeleteAccountSuccess) {
          CherryToast.success(
            title: Text(state.successModel['status']),
            animationType: AnimationType.fromTop,
          ).show(context);
          singOut(context);
        } else if (state is DeleteAccountError) {
          CherryToast.error(
                  title: const Text("Error"),
                  displayIcon: false,
                  description: Text(state.errorModel),
                  animationType: AnimationType.fromTop,
                  animationDuration: const Duration(milliseconds: 1000),
                  autoDismiss: true)
              .show(context);
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<HomeCubit>(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Profile'.tr(context),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: const Color(0xff003441),
          ),
          backgroundColor: Colors.white,
          /*   appBar: AppBar(
            title: Text(
              'Sing out'.tr(context),
              style: const TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              padding: EdgeInsets.zero,
              icon:  const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              onPressed: () {
                singOut(context);
              },
            ),
            actions: [
              IconButton(
                padding: EdgeInsets.zero,
                icon:  const Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen(),));
                },
              ),
            ],
          ),*/
          bottomSheet: Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height / 1.5,
            decoration: BoxDecoration(
              color: const Color(0xff003441),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -60,
                  right: 0,
                  left: 0,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: const Color(0xff003441),
                    child: CircleAvatar(
                      radius: 75,
                      backgroundImage: NetworkImage(HomeCubit.get(context)
                          .userData!
                          .data!
                          .user!
                          .avatar
                          .toString()),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        cubit.userData?.data?.user?.name ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'E-mail'.tr(context),
                            style: const TextStyle(
                              color: Color(0xFFBF8148),
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            cubit.userData?.data?.user?.email ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Text(
                          //   'Phone Number'.tr(context),
                          //   style: const TextStyle(
                          //     color: Color(0xFFBF8148),
                          //     fontSize: 18,
                          //     fontWeight: FontWeight.w400,
                          //   ),
                          // ),
                          Text(
                            cubit.userData?.data?.user?.phone ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Address'.tr(context),
                            style: const TextStyle(
                              color: Color(0xFFBF8148),
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            cubit.userData?.data?.user?.address ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          /*    body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 42,
                    ),
                    Center(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                        CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          radius: 75,
                          backgroundImage: NetworkImage(
                              HomeCubit.get(context).userData!.data!.user!.avatar.toString()),
                        ),
                        ),
                           IconButton(
                            onPressed: () {
                              setState(() {
                                isChangePhoto = true ;
                              });
                              HomeCubit.get(context).getPostImage(ImageSource.gallery,);
                            },
                            icon: const CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.black,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                  size: 20,
                                )),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 41,
                    ),
                    TextFromFiledEditProfile(
                        title: 'Full Name'.tr(context),
                        controller: fullNameController,
                        keyboardType: TextInputType.name,
                        hintText: cubit.userData?.data?.user?.name ?? 'User Name'),

                    const SizedBox(
                      height: 21,
                    ),
                    TextFromFiledEditProfile(
                        title: 'E-mail'.tr(context),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: cubit.userData?.data?.user?.email ?? 'User Email'),
               */ /*     const SizedBox(
                      height: 21,
                    ),

                    TextFromFiledEditProfile(
                        title: 'Phone Number',
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        hintText: cubit.userData?.data?.user?.id ?? 'User Phone'),*/ /*

                    const SizedBox(
                      height: 21,
                    ),

                    TextFromFiledEditProfile(
                        title: 'Address'.tr(context),
                        controller: addressController,
                        keyboardType: TextInputType.streetAddress,
                        hintText: cubit.userData?.data?.user?.address ?? 'User Phone'),
                    const SizedBox(
                      height: 15,
                    ),

                    TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NewPassword(),));
                        },
                        child:  Text(
                          'Change password'.tr(context),
                          style: TextStyle(
                            color: ColorManager.primary,
                            fontSize: 18,
                            fontFamily: FontConstants.fontFamilyRobotoFlex,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                            height: 0.08,
                          ),
                        )
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Conditional.single(
                      context: context,
                      conditionBuilder: (BuildContext context) => state is! EditProfileLoading,
                      widgetBuilder: (context) {
                        return Container(
                          width: double.infinity,
                          height: 58,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: TextButton(
                            onPressed: () {
                              cubit.updateProfile(
                                  username:fullNameController.text,
                                  address: addressController.text,
                                  avatar:  HomeCubit.get(context).postImage  ,
                              );
                            },
                            style: TextButton.styleFrom(
                              shape:  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              // backgroundColor: ColorManager.primary,
                              backgroundColor: Colors.green
                            ),
                            child:  Text(
                              "Save".tr(context),
                              style:   const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },fallbackBuilder: (BuildContext context) => const Center(child: CircularProgressIndicator()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      width: double.infinity,
                      height: 58,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: TextButton(
                        onPressed: () {
                          showDialog(context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Delete Account'.tr(context)),
                                content: Text('Are you sure you want to delete your account?'.tr(context)),
                                actions: [
                                  Form(
                                    key: formKey,
                                    child: TextFiledEgypt(
                                      textEditingController: currentPasswordController,
                                      keyboardType: TextInputType.visiblePassword,
                                      title: 'Current Password'.tr(context),
                                      iconData: Icons.lock,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Password must not be empty'.tr(context);
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child:  Text('Cancel'.tr(context)),
                                      ),
                                      const Spacer(),
                                      TextButton(
                                        onPressed: () {
                                          if(formKey.currentState!.validate())
                                          {
                                            cubit.deleteAccount(password: currentPasswordController.text);
                                          }
                                        },
                                        child:  Text('Delete'.tr(context)),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                          );
                        },
                        style: TextButton.styleFrom(
                          shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.red,
                        ),
                        child:  Text(
                          "Delete Account".tr(context),
                          style:   const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),*/
        );
      },
    );
  }
}
