abstract class SocialRegisterState {}

class SocialRegisterInitialState extends SocialRegisterState {}

class SocialRegisterLoadingState extends SocialRegisterState {}

class SocialRegisterSuccessState extends SocialRegisterState {}

class SocialRegisterErrorState extends SocialRegisterState {
  String error;

  SocialRegisterErrorState(this.error);
}

class SocialCreateUserLoadingState extends SocialRegisterState {}

class SocialCreateUserSuccessState extends SocialRegisterState
{
  String uid ;

  SocialCreateUserSuccessState(this.uid);
}

class SocialCreateUserErrorState extends SocialRegisterState {
  String error;

  SocialCreateUserErrorState(this.error);
}
