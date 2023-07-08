abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  String error;

  SocialGetUserErrorState(this.error);
}

class SocialChangeBottomNavBar extends SocialStates {}

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUploadCoverImageLoadingState extends SocialStates {}

class SocialUpdateImageError extends SocialStates {}

class SocialUpdateProfileLoadingState extends SocialStates {}

class SocialUpdateCoverLoadingState extends SocialStates {}

// Create  Posts

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  String error;

  SocialGetPostsErrorState(this.error);
}

// Liks

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {}

//get all users

class SocialGetAllUserSuccessState extends SocialStates {}

class SocialGetAllUserLoadingState extends SocialStates {}

class SocialGetAllUserErrorState extends SocialStates {
  String error;

  SocialGetAllUserErrorState(this.error);
}

// Messages

class SendMessageSuccessState extends SocialStates {}

class SendMessageErrorState extends SocialStates {}

class GetMessageSuccessState extends SocialStates {}

class GetMessageErrorState extends SocialStates {}
