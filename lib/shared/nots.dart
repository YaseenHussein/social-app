//  ConditionalBuilder(
//             condition: AppCubit().get(context).userModel != null,
//             builder: (context) {
//               var appCubit = AppCubit().get(context);
//               return Column(
//                 children: [
                //   if (!FirebaseAuth.instance.currentUser!.emailVerified)
                //     Container(
                //       color: Colors.amber.withOpacity(0.6),
                //       child: Padding(
                //         padding: const EdgeInsetsDirectional.symmetric(
                //             horizontal: 15),
                //         child: Row(
                //           children: [
                //             const Icon(Icons.info_outline),
                //             const SizedBox(
                //               width: 15,
                //             ),
                //             const Text("Please verify Your Email"),
                //             const Spacer(),
                //             defaultTextButton(
                //                 onPress: () {
                //                   FirebaseAuth.instance.currentUser!
                //                       .sendEmailVerification()
                //                       .then((value) {
                //                     showTost(
                //                         msg: "تحقق من ابريد الكتروني",
                //                         state: TostState.SUCCESS);
                //                   }).catchError((error) {
                //                     print(error);
                //                   });
                //                 },
                //                 label: "send")
                //           ],
                //         ),
                //       ),
                //     ),
                
          //        ],
          //     );
          //   },
          //   fallback: (context) =>
          //       const Center(child: CircularProgressIndicator()),
          // ),
       