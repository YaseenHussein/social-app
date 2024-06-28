import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../AppCubit/app_cubit.dart';
import '../../AppCubit/app_states.dart';
import '../../shared/componts.dart/componnts.dart';
import '../../shared/style/icon_broken.dart';

class NewsPost extends StatelessWidget {
  const NewsPost({super.key});

  get defaultColorThem => null;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit().get(context);
        var now = DateTime.now();
        var textController = TextEditingController();
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: "Create Post", actions: [
            defaultTextButton(
                onPress: () {
                  if (cubit.imagePost == null) {
                    cubit.createPost(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                  } else {
                    cubit.uploadImagePost(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                  }
                },
                label: "Post"),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is AppCreatePostLoading)
                  const LinearProgressIndicator(),
                if (state is AppCreatePostLoading)
                  const SizedBox(
                    height: 20,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          NetworkImage('${cubit.userModel!.image}'),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        "${cubit.userModel!.name}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "what is on Your mined"),
                  ),
                ),
                if (cubit.imagePost != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(cubit.imagePost!),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cubit.removePostImage();
                        },
                        icon: const CircleAvatar(
                          radius: 20,
                          child: Icon(
                            Icons.close,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            cubit.getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 5,
                              ),
                              Text("add photo"),
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text("# tags"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
