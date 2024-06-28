import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/chats/chat_detials.dart';
import 'package:social_app/shared/componts.dart/componnts.dart';

import '../../AppCubit/app_cubit.dart';
import '../../AppCubit/app_states.dart';
import '../../models/user_model.dart';
import '../../shared/style/icon_broken.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  get defaultColorThem => null;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit().get(context);
        return ConditionalBuilder(
            condition: cubit.allUserDataModel.isNotEmpty,
            builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildChatUser(cubit.allUserDataModel[index], context),
                separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsetsDirectional.only(start: 20),
                      child: Container(
                        color: Colors.grey,
                        height: 1,
                        width: double.infinity,
                      ),
                    ),
                itemCount: cubit.allUserDataModel.length),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget buildChatUser(UserModel model, context) {
    return InkWell(
      onTap: () {
        navigatorTo(context, ChatDetailsScreen(model: model));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage('${model.image}'),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                "${model.name}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Icon(IconBroken.Arrow___Right_2)
          ],
        ),
      ),
    );
  }
}
