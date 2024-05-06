import 'package:egytraveler/layout/homeLayout/cubit/state.dart';
import 'package:egytraveler/core/resources/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../layout/homeLayout/cubit/cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../core/resources/color_manager.dart';
import '../Auth/widget/text_filed_egypt.dart';
import '../newPassword/new_password.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'edit_profile.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> themeMode = [
    "Dark",
    "Light",
    "System",
  ];

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController currentPasswordController =
        TextEditingController();
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is DeleteAccountSuccess) {
          singOut(context);
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<HomeCubit>(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color(0xFF003340),
            title: Text(
              'Settings'.tr(context),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: Conditional.single(
            context: context,
            conditionBuilder: (context) => state is! LoadingGetUserData,
            widgetBuilder: (context) => SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 7,
                      ),
                      /*   Center(
                    child: Text(
                      'Settings'.tr(context),
                      style: const TextStyle(
                        color: Color(0xFF003340),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,

                      ),
                    ),
                  ),*/
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 190,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                if (HomeCubit.get(context).postImage != null)
                                  CircleAvatar(
                                    radius: 80,
                                    backgroundColor: Colors.black,
                                    child: CircleAvatar(
                                      radius: 75,
                                      backgroundImage: FileImage(
                                          HomeCubit.get(context).postImage!),
                                    ),
                                  ),
                                if (HomeCubit.get(context).postImage == null)
                                  CircleAvatar(
                                    radius: 80,
                                    backgroundColor: Colors.black,
                                    child: CircleAvatar(
                                      radius: 75,
                                      backgroundImage:
                                          cubit.userData?.data?.user?.avatar !=
                                                  null
                                              ? NetworkImage(cubit.userData
                                                      ?.data?.user?.avatar
                                                      .toString() ??
                                                  '')
                                              : const NetworkImage(
                                                  'https://t3.ftcdn.net/jpg/03/29/17/78/360_F_329177878_ij7ooGdwU9EKqBFtyJQvWsDmYSfI1evZ.jpg',
                                                ),
                                      child: cubit.userData?.data?.user
                                                  ?.avatar !=
                                              null
                                          ? null
                                          : Text(
                                              cubit.userData?.data?.user
                                                      ?.name?[0]
                                                      .toUpperCase() ??
                                                  '',
                                              style: TextStyle(
                                                fontSize: 35,
                                                color:
                                                    ColorManager.kColorPrimary,
                                              ),
                                            ),
                                    ),
                                  ),
                                IconButton(
                                  onPressed: () async {
                                    await HomeCubit.get(context).getPostImage(
                                      ImageSource.gallery,
                                    );
                                    await showAdaptiveDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor:
                                                const Color(0xff410000),
                                            title: Center(
                                                child: Text(
                                              'Are you sure you want to change your profile picture?'
                                                  .tr(context),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            )),
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        cubit.discardChange();
                                                        HomeCubit.get(context)
                                                            .postImage = null;
                                                        print(HomeCubit.get(
                                                                context)
                                                            .postImage);
                                                      });
                                                      HomeCubit.get(context)
                                                          .postImage = null;
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Discard Change'
                                                          .tr(context),
                                                      style: const TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      cubit
                                                          .updateProfile(
                                                        username: cubit
                                                                .userData
                                                                ?.data
                                                                ?.user
                                                                ?.name
                                                                .toString() ??
                                                            '',
                                                        address: cubit
                                                                .userData
                                                                ?.data
                                                                ?.user
                                                                ?.address
                                                                .toString() ??
                                                            '',
                                                        phone: cubit
                                                                .userData
                                                                ?.data
                                                                ?.user
                                                                ?.phone
                                                                .toString() ??
                                                            '',
                                                        avatar: HomeCubit.get(
                                                                context)
                                                            .postImage,
                                                      )
                                                          .then((value) {
                                                        cubit.getUserData();
                                                      });

                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Change'.tr(context),
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        });
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
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      /*   if (HomeCubit.get(context).postImage != null)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003340),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: (){
                      cubit.updateProfile(
                        username: cubit.userData!.data!.user!.name.toString(),
                        address: cubit.userData!.data!.user!.address.toString(),
                        avatar:  HomeCubit.get(context).postImage  ,
                      );
                      HomeCubit.get(context).postImage = null ;
                    },
                    child:SizedBox(
                      width: 150,
                      height: 47,
                      child: Center(
                        child: Text(
                          'Save'.tr(context),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,

                          ),
                        ),
                      ),
                    ),
                  ),*/
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        HomeCubit.get(context)
                                .userData
                                ?.data
                                ?.user
                                ?.name
                                .toString() ??
                            '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF003340),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      /*    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003340),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  EditProfileScreen(),));
                    },
                    child:SizedBox(
                      width: 181,
                      height: 47,
                      child: Center(
                        child: Text(
                          'Edit Profile'.tr(context),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,

                          ),
                        ),
                      ),
                    ),
                ),*/

                      const SizedBox(
                        height: 30,
                      ),

                      /*   Container(
                    width: double.infinity,
                    height: 35,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFD9D9D9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: Align(
                        alignment: HomeCubit.get(context).locale.toString() == 'en' ? Alignment.centerLeft : Alignment.centerRight,
                        child: Text(
                          'Content'.tr(context),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),*/

                      /*  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MyTripsScreen(),));
                    },
                    child: Content(
                      icon: Icons.map_sharp,
                      text: 'My Trips'.tr(context),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const MyTripsScreen(),));
                      },
                    ),
                  ),*/
                      Container(
                        width: double.infinity,
                        height: 35,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          child: Align(
                            alignment:
                                HomeCubit.get(context).locale.toString() == 'en'
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                            child: Text(
                              'Settings'.tr(context),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfileScreen(),
                              ));
                        },
                        child: Content(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfileScreen(),
                                ));
                          },
                          icon: Icons.favorite_border_rounded,
                          text: 'Edit Profile'.tr(context),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfileScreen(),
                                ));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewPassword(),
                              ));
                        },
                        child: Content(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewPassword(),
                                ));
                          },
                          icon: Icons.password_outlined,
                          text: 'Change password'.tr(context),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewPassword(),
                                ));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    backgroundColor: const Color(0xff410000),
                                    title: Center(
                                        child: Text(
                                      'Delete Account'.tr(context),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )),
                                    content: Text(
                                      'Are you sure you want to delete your account?'
                                          .tr(context),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    actions: [
                                      Form(
                                        key: formKey,
                                        child: TextFiledEgypt(
                                          textEditingController:
                                              currentPasswordController,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              HomeCubit.get(context)
                                                  .changePasswordVisibility();
                                            },
                                            icon: Icon(
                                              HomeCubit.get(context).suffix,
                                            ),
                                          ),
                                          obscureText: HomeCubit.get(context)
                                              .isPasswordShown,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          title: 'Current Password'.tr(context),
                                          iconData: Icons.lock,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Password must not be empty'
                                                  .tr(context);
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
                                            child: Text(
                                              'Cancel'.tr(context),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          const Spacer(),
                                          TextButton(
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                cubit.deleteAccount(
                                                    password:
                                                        currentPasswordController
                                                            .text);
                                              }
                                            },
                                            child: Text(
                                              'Delete'.tr(context),
                                              style: const TextStyle(
                                                  color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ));
                        },
                        child: Content(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      backgroundColor: const Color(0xff410000),
                                      title: Center(
                                          child: Text(
                                        'Delete Account'.tr(context),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )),
                                      content: Text(
                                        'Are you sure you want to delete your account?'
                                            .tr(context),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      actions: [
                                        Form(
                                          key: formKey,
                                          child: TextFiledEgypt(
                                            textEditingController:
                                                currentPasswordController,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                HomeCubit.get(context)
                                                    .changePasswordVisibility();
                                              },
                                              icon: Icon(
                                                HomeCubit.get(context).suffix,
                                              ),
                                            ),
                                            obscureText: HomeCubit.get(context)
                                                .isPasswordShown,
                                            title:
                                                'Current Password'.tr(context),
                                            iconData: Icons.lock,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Password must not be empty'
                                                    .tr(context);
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
                                              child: Text(
                                                'Cancel'.tr(context),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            const Spacer(),
                                            TextButton(
                                              onPressed: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  cubit.deleteAccount(
                                                      password:
                                                          currentPasswordController
                                                              .text);
                                                }
                                              },
                                              child: Text(
                                                'Delete'.tr(context),
                                                style: const TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ));
                          },
                          icon: Icons.delete_outlined,
                          text: 'Delete Account'.tr(context),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      backgroundColor: const Color(0xff410000),
                                      title: Center(
                                          child: Text(
                                        'Delete Account'.tr(context),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )),
                                      content: Text(
                                        'Are you sure you want to delete your account?'
                                            .tr(context),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      actions: [
                                        Form(
                                          key: formKey,
                                          child: TextFiledEgypt(
                                            textEditingController:
                                                currentPasswordController,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                HomeCubit.get(context)
                                                    .changePasswordVisibility();
                                              },
                                              icon: Icon(
                                                HomeCubit.get(context).suffix,
                                              ),
                                            ),
                                            obscureText: HomeCubit.get(context)
                                                .isPasswordShown,
                                            title:
                                                'Current Password'.tr(context),
                                            iconData: Icons.lock,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Password must not be empty'
                                                    .tr(context);
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
                                              child: Text(
                                                'Cancel'.tr(context),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            const Spacer(),
                                            TextButton(
                                              onPressed: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  cubit.deleteAccount(
                                                      password:
                                                          currentPasswordController
                                                              .text);
                                                }
                                              },
                                              child: Text(
                                                'Delete'.tr(context),
                                                style: const TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.dark_mode_outlined,
                            color: ColorManager.kColorPrimary,
                            size: 32,
                          ),
                          const SizedBox(
                            width: 13,
                          ),
                          Text(
                            'Theme mode'.tr(context),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          DropdownButton(
                            dropdownColor: ColorManager.kColorPrimary,
                            borderRadius: BorderRadius.circular(10),
                            value: themeModeCacheHelper,
                            items: themeMode
                                .map<DropdownMenuItem<String>>(
                                  (String e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      )),
                                )
                                .toList(),
                            icon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: Colors.grey,
                            ),
                            iconSize: 32,
                            elevation: 4,
                            underline: Container(
                              height: 0,
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                HomeCubit.get(context).themeModeText = value!;
                                HomeCubit.get(context)
                                    .changeAppMode(theme: value);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            fallbackBuilder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
