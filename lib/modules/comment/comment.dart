import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/style/colors.dart';

import '../../AppCubit/app_cubit.dart';
import '../../AppCubit/app_states.dart';
import '../../models/comment_model.dart';
import '../../shared/style/icon_broken.dart';

class CommentScreen extends StatelessWidget {
  BuildContext? contextComment;
  String? postId;
  String? postImage;
  String? userName;
  int? index;
  CommentScreen({
    required this.contextComment,
    required this.postId,
    required this.postImage,
    required this.userName,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    AppCubit().get(context).getCommentData(postId!);
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              //AppCubit().get(context).getPostData();
              Navigator.pop(context);
            },
            icon: const Icon(IconBroken.Arrow___Left_2),
          ),
          title: const Text("Comments"),
        ),
        body: //ConditionalBuilder(
            //     condition: AppCubit().get(context).listCommentModel.isNotEmpty,
            //     builder: (context) {
            //       return
            showCommentSheet(
          context: context,
          index: index,
          userName: userName,
          postId: postId,
          postImage: postImage,
        ),
        // },
        // fallback: (context) {
        //   return const Center(child: CircularProgressIndicator());
        // }
      );
    });
  }
}

Widget showCommentSheet({context, postId, postImage, userName, index}) {
  var cubit = AppCubit().get(context);
  var commentController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        width: double.infinity,
        //height: 500,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        commentText(cubit.listCommentModel[index], context),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemCount: cubit.listCommentModel.length),
              ),
              const SizedBox(
                height: 55,
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 50,
          padding: const EdgeInsetsDirectional.only(start: 5),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300, width: 1.0)),
          child: Form(
            key: formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: commentController,
                    validator: (value) {
                      if (value.toString().isEmpty)
                        return "should Enter a comment";
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Write comments here ....",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                MaterialButton(
                    color: defaultColorThem,
                    minWidth: 1.0,
                    height: 50,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        cubit.putComment(
                            postId: postId,
                            comment: commentController.text,
                            image: postImage);
                      }
                    },
                    child: const Icon(
                      IconBroken.Send,
                      size: 16,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ),
      ),

      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Container(
      //     padding: const EdgeInsets.all(8),
      //     decoration: BoxDecoration(
      //         color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      //     child: Form(
      //       key: formKey,
      //       child: TextFormField(
      //         controller: commentController,
      //         validator: (value) {
      //           if (value.toString().isEmpty) return "should Enter a comment";
      //           return null;
      //         },
      //         decoration: InputDecoration(
      //           hintText: "Write a comments",
      //           border: InputBorder.none,
      //           suffixIcon: IconButton(
      //             onPressed: () {
      //               if (formKey.currentState!.validate()) {
      //                 cubit.putComment(
      //                     postId: postId,
      //                     comment: commentController.text,
      //                     image: postImage);
      //               }
      //             },
      //             icon: Icon(
      //               Icons.send,
      //               color: defaultColorThem,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    ],
  );
}

Widget commentText(CommentModel model, context) {
  return Row(
    children: [
      CircleAvatar(
        radius: 18,
        backgroundImage: NetworkImage("${model.image}"),
      ),
      const SizedBox(
        width: 10,
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsetsDirectional.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              bottomEnd: Radius.circular(10),
            ),
          ),
          child: Text("${model.comment}"),
        ),
      ),
    ],
  );
}
