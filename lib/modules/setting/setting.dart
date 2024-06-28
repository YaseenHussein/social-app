import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/profile/edit_profile.dart';
import 'package:social_app/shared/componts.dart/componnts.dart';
import 'package:social_app/shared/style/icon_broken.dart';

import '../../AppCubit/app_cubit.dart';
import '../../AppCubit/app_states.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var model = AppCubit().get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 200,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadiusDirectional.only(
                              topEnd: Radius.circular(8),
                              topStart: Radius.circular(8)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('${model!.cover}'),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage("${model.image}"),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${model.name}",
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "${model.bio}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              "100",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "Posts",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              "362",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "Photo",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              "10k",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "Followers",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              "53",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "Followings",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        child: const Text("Add Photos"), onPressed: () {}),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        navigatorTo(context, EditProfile());
                      },
                      child: const Icon(
                        IconBroken.Edit,
                        size: 20,
                      ))
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        FirebaseMessaging.instance.subscribeToTopic("yaseen");
                        print("subscribe");
                      },
                      child: const Text("subscript"),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () {
                          FirebaseMessaging.instance
                              .unsubscribeFromTopic("yaseen");
                          print("subscribe");
                        },
                        child: const Text("unsubscribe")),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
