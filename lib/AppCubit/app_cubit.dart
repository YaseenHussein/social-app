import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/massage_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats.dart';
import 'package:social_app/modules/feeds/feeds.dart';
import 'package:social_app/modules/setting/setting.dart';
import 'package:social_app/shared/componts.dart/constants.dart';
import 'package:social_app/shared/style/icon_broken.dart';

import '../modules/post/news_post.dart';
import '../shared/network/local/cache_helper.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  AppCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  void getUserData() {
    emit(AppLoadingGetUser());
    FirebaseFirestore.instance.collection("Users").doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(AppGetUserSuccuss());
    }).catchError((error) {
      print(error);
      emit(AppGetUserError(error.toString()));
    });
  }

  void isFromLogin(bool isLogin) {
    if (isLogin) {
      getUserData();
      getPostData();
      getAllUserData();
      emit(AppIsLoginState());
    }
  }

  int currentIndex = 0;
  List<Widget> screens = const [
    FeedsScreen(),
    ChatScreen(),
    NewsPost(),
    SettingScreen(),
  ];
  List<BottomNavigationBarItem> listNavBar = const [
    BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(IconBroken.Chat), label: "Chat"),
    BottomNavigationBarItem(icon: Icon(IconBroken.Message), label: "Post"),
    BottomNavigationBarItem(icon: Icon(IconBroken.Setting), label: "Setting"),
  ];
  List<String> title = [
    'Home',
    'Chat',
    'Post',
    'Setting',
  ];
  void changeCurrentIndex(index) {
    if (index == 2) {
      emit(AppChangePostNavBar());
    } else {
      currentIndex = index;
      if (index == 1) getAllUserData();
      emit(AppChangeNavBarItem());
    }
  }

  File? imageProfile;

  ImagePicker imagePicker = ImagePicker();
  void getProfileImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageProfile = File(image.path);
      emit(AppProfileImagePickedSuccuss());
    } else {
      print("not Image Selected");
      emit(AppProfileImagePickedError());
    }
  }

  File? imageCover;
  Future<void> getCoverImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageCover = File(image.path);
      emit(AppProfileImageCoverPickedSuccuss());
    } else {
      print("not Image Selected");
      emit(AppProfileImageCoverPickedError());
    }
  }

  final storage = FirebaseStorage.instance;
  void uploadImageProfile({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(AppUpdateUserDataLoading());
    storage
        .ref() //ابدء ادخل الى داخل
        .child(
          "User/${Uri.file(imageProfile!.path).pathSegments.last}",
        ) //اتحرك داخلها واخذ اخر مسار اي اخر سجمنت
        .putFile(imageProfile!) //رفع الملف الى الفاير بيس
        .then((value) {
      //emit(AppUploadProfileImageSuccuss());
      value.ref.getDownloadURL().then((value) {
        updateDate(
          bio: bio,
          name: name,
          phone: phone,
          image: value,
        );
        imageProfile = null;
      }).catchError((error) {
        // ignore: avoid_print
        print(error);
        emit(AppUploadProfileImageError());
      });
    }).catchError((error) {
      emit(AppUploadProfileImageError());
    });
  }

  void uploadImageCover({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(AppUpdateUserDataLoading());
    storage
        .ref() //ابدء ادخل الى داخل
        .child(
          "User/${Uri.file(imageCover!.path).pathSegments.last}",
        ) //اتحرك داخلها واخذ اخر مسار اي اخر سجمنت
        .putFile(imageCover!) //رفع الملف الى الفاير بيس
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateDate(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
        imageCover = null;
      }).catchError((error) {
        // ignore: avoid_print
        print(error);
        emit(AppUploadCoverImageError());
      });
    }).catchError((error) {
      emit(AppUploadCoverImageError());
    });
  }

  void updateDate({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    UserModel userModel = UserModel(
      name: name,
      phone: phone,
      image: image ?? this.userModel!.image,
      bio: bio,
      email: this.userModel!.email,
      uId: this.userModel!.uId,
      cover: cover ?? this.userModel!.cover,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(AppUpdateUserDataError());
    });
  }

  File? imagePost;
  Future<void> getPostImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePost = File(image.path);
      emit(AppImagePostPickedSuccuss());
    } else {
      // ignore: avoid_print
      print("not Image Selected");
      emit(AppImagePostPickedError());
    }
  }

  void removePostImage() {
    imagePost = null;
    emit(AppRemovePostImage());
  }

  void uploadImagePost({
    required String dateTime,
    required String text,
  }) {
    emit(AppCreatePostLoading());
    storage
        .ref()
        .child(
          "Post/${Uri.file(imagePost!.path).pathSegments.last}",
        )
        .putFile(imagePost!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
        imagePost = null; //بعد الااضافة الصورة افرغ المخزن
      }).catchError((error) {
        // ignore: avoid_print
        print(error);
        emit(AppImagePostPickedError());
      });
    }).catchError((error) {
      emit(AppImagePostPickedError());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(AppCreatePostLoading());
    PostModel model = PostModel(
      name: userModel!.name,
      uId: uId,
      image: userModel!.image,
      dateTime: dateTime,
      postImage: postImage ?? "",
      text: text,
    );
    FirebaseFirestore.instance
        .collection("Post")
        .add(model.toMap())
        .then((value) {
      getPostData();
      emit(AppCreatePostSuccess());
    }).catchError((error) {
      emit(AppCreatePostError());
    });
  }

  List<PostModel> listPostModel = [];
  List<CommentModel> listCommentModel = [];
  List<String> listPost = [];
  // List<String> listPostComment = [];

  List<int> likes = [];
  List<int> comment = [];

  void getPostData() async {
    listPostModel = [];
    listCommentModel = [];
    listPost = [];
    likes = [];
    comment = [];
    await FirebaseFirestore.instance.collection("Post").get().then((value) {
      for (var element in value.docs) {
        element.reference.collection("comment").get().then((value) {
          comment.add(value.docs.length);
          listPostModel.add(PostModel.fromJson(element.data()));
          listPost.add(element.id);
        }).catchError((error) {
          emit(AppGetCommentPostError(error.toString()));
        });
        element.reference.collection("Like").get().then((value) {
          likes.add(value.docs.length);
          emit(AppGetPostSuccuss());
        }).catchError((error) {
          emit(AppGetCommentPostError(error.toString()));
        });
      }
      emit(AppGetPostSuccuss());
    }).catchError((error) {
      emit(AppGetPostError(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection("Post")
        .doc(postId)
        .collection("Like")
        .doc(userModel!.uId)
        .set({
      "like": true,
    }).then((value) {
      emit(AppLikePostSuccuss());
    }).catchError((error) {
      emit(AppGetPostSuccuss());
    });
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  void putComment(
      {required String postId,
      required String comment,
      required String image}) {
    emit(AppCommentPostLoading());
    CommentModel listComment = CommentModel(comment: comment, image: image);
    FirebaseFirestore.instance
        .collection("Post")
        .doc(postId)
        .collection("comment")
        .add(listComment.toMap())
        .then((value) {
      getCommentData(postId);
      emit(AppCommentPostSuccuss());
    }).catchError((error) {
      emit(AppCommentPostError(error.toString()));
    });
  }

  void getCommentData(String postId) {
    //listCommentModel = [];
    emit(AppGetCommentPostLoading());
    FirebaseFirestore.instance
        .collection("Post")
        .doc(postId)
        .collection("comment")
        .snapshots() //القانه الاستريم
        .listen((value) {
      listCommentModel = [];
      for (var element in value.docs) {
        listCommentModel.add(CommentModel.fromJson(element.data()));
      }
      emit(AppGetCommentPostSuccuss());
    });
  }

  List<UserModel> allUserDataModel = [];
  void getAllUserData() {
    if (allUserDataModel.isEmpty) {
      emit(AppLoadingGetAllUser());
      FirebaseFirestore.instance.collection("Users").get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != userModel!.uId)
            allUserDataModel.add(UserModel.fromJson(element.data()));
        }
        emit(AppGetAllUserSuccuss());
      }).catchError((error) {
        print(error.toString());
        emit(AppGetAllUserError(error.toString()));
      });
    }
  }

  void sendMassage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MassageModel model = MassageModel(
        senderId: userModel!.uId,
        receiverId: receiverId,
        dateTime: dateTime,
        text: text);
    FirebaseFirestore.instance
        .collection("Users")
        .doc(userModel!.uId)
        .collection("chat")
        .doc(receiverId)
        .collection("massage")
        .add(model.toMap())
        .then((value) {
      emit(AppSendMassageSuccesses());
    }).catchError((error) {
      print(error.toString());
      emit(AppSendMassageError());
    });

    FirebaseFirestore.instance
        .collection("Users")
        .doc(receiverId)
        .collection("chat")
        .doc(userModel!.uId)
        .collection("massage")
        .add(model.toMap())
        .then((value) {
      emit(AppSendMassageSuccesses());
    }).catchError((error) {
      print(error.toString());
      emit(AppSendMassageError());
    });
  }

  List<MassageModel> massage = [];
  void getMassage({required String receiverId}) {
    massage = [];
    print("Get Massage");
    FirebaseFirestore.instance
        .collection("Users")
        .doc(userModel!.uId)
        .collection("chat")
        .doc(receiverId)
        .collection("massage")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      massage = [];
      for (var element in event.docs) {
        print(element.data());
        massage.add(MassageModel.fromJson(element.data()));
        print("Massage Length " + massage.length.toString());
        emit(AppGetMassageSuccesses());
      }
      //print("Massage Length " + massage.length.toString());
      emit(AppGetMassageSuccesses());
    });
  }
}
