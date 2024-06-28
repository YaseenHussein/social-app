import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/massage_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/call/call_page.dart';
import 'package:social_app/modules/call/call_page_adio.dart';
import 'package:social_app/shared/componts.dart/componnts.dart';
import 'package:social_app/shared/style/colors.dart';
import 'package:social_app/shared/style/icon_broken.dart';

import '../../AppCubit/app_cubit.dart';
import '../../AppCubit/app_states.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel model;

  ChatDetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      AppCubit().get(context).getMassage(receiverId: model.uId!);
      return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = AppCubit().get(context);
          var textController = TextEditingController();
          return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage("${model.image}"),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "${model.name}",
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        navigatorTo(
                            context,
                            HomeCallAudio(
                              userName: "${model.name}",
                              imageUrl: "${model.image}",
                            ));
                      },
                      icon: const Icon(Icons.call)),
                  IconButton(
                      onPressed: () {
                        navigatorTo(
                            context,
                            HomeCall(
                              userName: "${model.name}",
                              imageUrl: "${model.image}",
                            ));
                      },
                      icon: const Icon(Icons.video_call))
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ConditionalBuilder(
                        condition: cubit.massage.isNotEmpty,
                        builder: (context) => Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  if (cubit.massage[index].senderId ==
                                      cubit.userModel!.uId) {
                                    return buildMyMassage(cubit.massage[index]);
                                  }
                                  return buildSenderMassage(
                                      cubit.massage[index]);
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 15,
                                ),
                                itemCount: cubit.massage.length,
                              ),
                            ),
                          ],
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsetsDirectional.only(start: 5),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1.0)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: textController,
                              decoration: InputDecoration(
                                hintText: "type Your massages here ....",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          MaterialButton(
                              color: defaultColorThem,
                              minWidth: 1.0,
                              height: 50,
                              onPressed: () {
                                cubit.sendMassage(
                                    receiverId: model.uId!,
                                    dateTime: DateTime.now().toString(),
                                    text: textController.text);
                              },
                              child: const Icon(
                                IconBroken.Send,
                                size: 16,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ));
        },
      );
    });
  }
}

Widget buildSenderMassage(MassageModel model) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            )),
        child: Text("${model.text}"),
      ),
    );
Widget buildMyMassage(MassageModel model) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
            color: defaultColorThem.withOpacity(0.2),
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            )),
        child: Text("${model.text}"),
      ),
    );
