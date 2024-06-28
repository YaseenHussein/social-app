import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/componts.dart/componnts.dart';
import 'package:social_app/shared/style/colors.dart';
import 'package:social_app/shared/style/icon_broken.dart';

import '../../AppCubit/app_cubit.dart';
import '../../AppCubit/app_states.dart';
import '../comment/comment.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit().get(context);
        return ConditionalBuilder(
            condition:
                cubit.listPostModel.isNotEmpty && cubit.userModel != null,
            builder: (context) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Card(
                        margin: const EdgeInsetsDirectional.all(8),
                        elevation: 5.0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Image(
                              image: NetworkImage("${cubit.userModel!.cover}"),
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "communicate with friends",
                                style: TextStyle(
                                    fontFamily: "Jannah",
                                    color: Colors.white,
                                    fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => buildPost(
                              cubit.listPostModel[index], context, index),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: cubit.listPostModel.length),
                    ],
                  ),
                ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }
}

Widget buildPost(PostModel postModel, context, index) {
  var cubit = AppCubit().get(context);

  return Card(
    margin: const EdgeInsetsDirectional.all(8),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('${postModel.image}'),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${postModel.name}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: defaultColorThem,
                          size: 16,
                        ),
                      ],
                    ),
                    Text(
                      "${postModel.dateTime}",
                      style: TextTheme().bodySmall,
                    )
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    IconBroken.More_Circle,
                    color: Colors.grey,
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              color: Colors.grey[300],
              height: 1.0,
              width: double.infinity,
            ),
          ),
          Text(
            "${postModel.text}",
            style: const TextStyle(
                fontSize: 17, fontFamily: 'Jannah', height: 1.3),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10.0),
                    child: Container(
                      height: 20,
                      child: MaterialButton(
                        ///////////////
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        /////////////////
                        onPressed: () {},
                        child: Text(
                          "#Flutter devlopment",
                          style: TextStyle(color: defaultColorThem),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10.0),
                    child: Container(
                      height: 20,
                      child: MaterialButton(
                        ///////////////
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        /////////////////
                        onPressed: () {},
                        child: Text(
                          "#IT engnering",
                          style: TextStyle(color: defaultColorThem),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (postModel.postImage != '')
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 8.0),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('${postModel.postImage}'))),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      cubit.likePost(cubit.listPost[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${cubit.likes[index]}",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            color: Colors.orange,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${cubit.comment[index]} comments",
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 13.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 10.0),
            child: Container(
              color: Colors.grey[300],
              height: 1.0,
              width: double.infinity,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    //cubit.listCommentModel = [];
                    // cubit.getCommentData(cubit.listPost[index]);
                    // cubit.scaffoldKey.currentState!.showBottomSheet((context) {
                    //   return showCommentSheet(
                    //     context: context,
                    //     postId: cubit.listPost[index],
                    //     postImage: postModel.postImage,
                    //     userName: cubit.userModel!.name,
                    //     index: index,
                    //   );
                    // });
                    navigatorTo(
                        context,
                        CommentScreen(
                          contextComment: context,
                          postId: cubit.listPost[index],
                          postImage: cubit.userModel!.image,
                          userName: cubit.userModel!.name,
                          index: index,
                        ));
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            NetworkImage('${cubit.userModel!.image}'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "write massage...",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  AppCubit().get(context).likePost(cubit.listPost[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Like",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
