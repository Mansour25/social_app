import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Bloc/register_cubit/register_states.dart';
import 'package:social_app/models/models.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterState> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  FirebaseAuth auth = FirebaseAuth.instance;
  String errorMessage = '';

  void UserRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());

    auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      CrearteUser(
        name: name,
        email: email,
        phone: phone,
        uid: value.user!.uid,
        image:
            'https://cdn3.vectorstock.com/i/1000x1000/32/12/default-avatar-profile-icon-vector-39013212.jpg',
        bio: "write your bio",
        cover:
            'https://free4kwallpapers.com/uploads/originals/2015/08/25/website-background.jpg',
      );
    }).onError((FirebaseAuthException error, stackTrace) {
      switch (error.code) {
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Anonymous accounts are not enabled";
          break;
        case "ERROR_WEAK_PASSWORD":
          errorMessage = "Your password is too weak";
          break;
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email is invalid";
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          errorMessage = "Email is already in use on different account";
          break;
        case "ERROR_INVALID_CREDENTIAL":
          errorMessage = "Your email is invalid";
          break;
        case "network-request-failed":
          errorMessage = "No internet connection";
          break;

        default:
          errorMessage = "An undefined Error happened.";
      }
      emit(SocialRegisterErrorState(errorMessage));
    });
  }

  FirebaseFirestore store = FirebaseFirestore.instance;

  void CrearteUser({
    required String name,
    required String email,
    required String phone,
    required String uid,
    required String image,
    required String bio,
    required String cover,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      bio: bio,
      uid: uid,
      profile: image,
      cover: cover,
      isEmailVerified: false,
    );
    store.collection('users').doc(uid).set(model.toMap()).then((value) {
      emit(SocialCreateUserSuccessState(uid));
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error));
    });
  }
}
