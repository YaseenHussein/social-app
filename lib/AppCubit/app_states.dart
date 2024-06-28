abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppLoadingGetUser extends AppStates {}

class AppGetUserSuccuss extends AppStates {}

class AppGetUserError extends AppStates {
  String error;
  AppGetUserError(this.error);
}

class AppLoadingGetPost extends AppStates {}

class AppGetPostSuccuss extends AppStates {}

class AppGetPostError extends AppStates {
  String error;
  AppGetPostError(this.error);
}

class AppChangeNavBarItem extends AppStates {}

class AppChangePostNavBar extends AppStates {}

class AppProfileImagePickedSuccuss extends AppStates {}

class AppProfileImagePickedError extends AppStates {}

class AppProfileImageCoverPickedSuccuss extends AppStates {}

class AppProfileImageCoverPickedError extends AppStates {}

class AppUploadProfileImageSuccuss extends AppStates {}

class AppUploadProfileImageError extends AppStates {}

class AppUploadCoverImageSuccuss extends AppStates {}

class AppUploadCoverImageError extends AppStates {}

class AppUpdateUserDataError extends AppStates {}

class AppUpdateUserDataLoading extends AppStates {}

// create Post
class AppCreatePostSuccess extends AppStates {}

class AppCreatePostLoading extends AppStates {}

class AppCreatePostError extends AppStates {}

class AppImagePostPickedSuccuss extends AppStates {}

class AppImagePostPickedError extends AppStates {}

class AppRemovePostImage extends AppStates {}

class AppLikePostSuccuss extends AppStates {}

class AppLikePostError extends AppStates {
  String error;
  AppLikePostError(this.error);
}

class AppCommentPostLoading extends AppStates {}

class AppCommentPostSuccuss extends AppStates {}

class AppCommentPostError extends AppStates {
  String error;
  AppCommentPostError(this.error);
}

class AppGetCommentPostLoading extends AppStates {}

class AppGetCommentPostSuccuss extends AppStates {}

class AppGetCommentPostError extends AppStates {
  String error;
  AppGetCommentPostError(this.error);
}

////Get  All User Data
class AppLoadingGetAllUser extends AppStates {}

class AppGetAllUserSuccuss extends AppStates {}

class AppGetAllUserError extends AppStates {
  String error;
  AppGetAllUserError(this.error);
}

////send Massage
class AppSendMassageSuccesses extends AppStates {}

class AppSendMassageError extends AppStates {}

class AppGetMassageSuccesses extends AppStates {}

class AppGetMassageLoading extends AppStates {}

class AppIsLoginState extends AppStates {}
