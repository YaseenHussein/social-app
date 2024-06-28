import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../AppCubit/app_cubit.dart';
import '../../AppCubit/app_states.dart';
import '../../shared/componts.dart/componnts.dart';
import '../../shared/style/icon_broken.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var bioController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit().get(context);
        var model = cubit.userModel;
        var profileImage = cubit.imageProfile;
        var coverImage = cubit.imageCover;
        nameController.text = model!.name!;
        bioController.text = model.bio!;
        phoneController.text = model.phone!;
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: "Edit Profile", actions: [
            defaultTextButton(
                onPress: () {
                  cubit.updateDate(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                },
                label: "Update"),
            const SizedBox(
              width: 15,
            ),
          ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                if (state is AppUpdateUserDataLoading)
                  const LinearProgressIndicator(),
                if (state is AppUpdateUserDataLoading)
                  const SizedBox(
                    height: 15,
                  ),
                Container(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 160,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadiusDirectional.only(
                                        topEnd: Radius.circular(8),
                                        topStart: Radius.circular(8)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: coverImage == null
                                      ? NetworkImage('${model.cover}')
                                      : FileImage(coverImage) as ImageProvider,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.getCoverImage();
                              },
                              icon: CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 64,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: (profileImage == null)
                                  ? NetworkImage("${model.image}")
                                  : FileImage(profileImage) as ImageProvider,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              cubit.getProfileImage();
                            },
                            icon: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                IconBroken.Camera,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                if (cubit.imageCover != null || cubit.imageProfile != null)
                  Row(
                    children: [
                      if (cubit.imageCover != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultMartialButton(
                                  label: "Update Cover",
                                  btnOnPress: () {
                                    cubit.uploadImageCover(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  }),
                              if (state is AppUpdateUserDataLoading)
                                const SizedBox(
                                  height: 5,
                                ),
                              if (state is AppUpdateUserDataLoading)
                                const LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      if (cubit.imageCover != null)
                        const SizedBox(
                          width: 8,
                        ),
                      if (cubit.imageProfile != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultMartialButton(
                                  label: "Update Image",
                                  btnOnPress: () {
                                    cubit.uploadImageProfile(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  }),
                              if (state is AppUpdateUserDataLoading)
                                const SizedBox(
                                  height: 5,
                                ),
                              if (state is AppUpdateUserDataLoading)
                                const LinearProgressIndicator(),
                            ],
                          ),
                        )
                    ],
                  ),
                const SizedBox(
                  height: 15,
                ),
                buildTextField(
                    controller: nameController,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "name must be not null";
                      }
                      return null;
                    },
                    label: "Name",
                    preFixIcon: IconBroken.User),
                const SizedBox(
                  height: 15,
                ),
                buildTextField(
                    controller: bioController,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "bio must be not null";
                      }
                      return null;
                    },
                    label: "bio",
                    preFixIcon: IconBroken.Info_Circle),
                const SizedBox(
                  height: 15,
                ),
                buildTextField(
                    controller: phoneController,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "phone must be not null";
                      }
                      return null;
                    },
                    label: "Phone Number",
                    preFixIcon: Icons.phone),
              ]),
            ),
          ),
        );
      },
    );
  }
}
