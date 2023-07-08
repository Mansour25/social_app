import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Bloc/SocialCubit/social_states.dart';
import 'package:social_app/Components/shortucts.dart';
import 'package:social_app/models/model_chat.dart';
import 'package:social_app/models/models.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/screens/HomeScreens/chats.dart';
import 'package:social_app/screens/HomeScreens/feeds.dart';
import 'package:social_app/screens/HomeScreens/settings.dart';
import 'package:social_app/screens/HomeScreens/users.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  change_index(int index) {
    if (index == 0) {
      getPosts();
    }

    if (index == 1) {
      getAllUsers();
    }

    currentIndex = index;
    emit(SocialChangeBottomNavBar());
  }

  List<IconData> icons = [
    Icons.home,
    Icons.chat_bubble_outline,
    Icons.place_outlined,
    Icons.settings,
    // Icons.settings,
  ];

  List<String> title = [
    'Home',
    'Chats',
    'Users',
    'Settings',
    'Settings',
  ];

  List<Widget> Screens = [
    Feeds(),
    Chats(),
    Users(),
    Settingss(),
  ];

  SocialUserModel? userModel;

  void getData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);
      print(userModel);
      emit(SocialGetUserSuccessState());
      print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
      print(value.data());
      print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
      print("Error ${error.toString()}");
    });
  }

  var picker = ImagePicker();

  File? ProfileImage;
  File? CoverImage;

  Future getProfileImage() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      ProfileImage = File(pickedImage.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  Future getCoverImage() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      CoverImage = File(pickedImage.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateCoverLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          'users/$uid/cover/${Uri.file(CoverImage!.path).pathSegments.last}',
        )
        .putFile(CoverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
        emit(SocialUploadCoverImageSuccessState());
        print(value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
        print(error.toString());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
      print(error.toString());
    });
  }

  String? profileIsLoagin;

  uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateProfileLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref() // يأخذ منها refrence
        .child(
          'users/$uid/profile/${Uri.file(ProfileImage!.path).pathSegments.last}',
        )
        .putFile(ProfileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          profile: value,
        );
        profileIsLoagin = 'profile upload done';
        emit(SocialUploadProfileImageSuccessState());
        print(value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
        print(error.toString());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
      print(error.toString());
    });
  }

  String? update_user_data_loagin;

  updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? profile,
  }) {
    {
      SocialUserModel model = SocialUserModel(
        name: name,
        phone: phone,
        bio: bio,
        uid: userModel!.uid,
        isEmailVerified: false,
        email: userModel!.email,
        cover: cover ?? userModel!.cover,
        profile: profile ?? userModel!.profile,
      );

      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update(model.toMap())
          .then((value) {
        getData();
      }).catchError((error) {
        emit(SocialUpdateImageError());
      });
    }
  }

  File? postImage;

  Future getPostImage() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      postImage = File(pickedImage.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void upload_post_image({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          'posts/${Uri.file(postImage!.path).pathSegments.last}',
        )
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        CreateNewPost(dateTime: dateTime, text: text, postImage: value);
        getPosts();
        emit(SocialCreatePostSuccessState());
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }























  CreateNewPost({
    String? postImage,
    required String dateTime,
    required String text,
  }) {
    {
      emit(SocialCreatePostLoadingState());

      PostModel model = PostModel(
        name: userModel!.name,
        uid: userModel!.uid,
        profile: userModel!.profile,
        dateTime: dateTime,
        postImage: postImage ?? '',
        text: text,
      );

      FirebaseFirestore.instance
          .collection('posts')
          .add(model.toMap())
          .then((value) {
        getPosts();
        emit(SocialCreatePostSuccessState());
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }
  }

  void removePostImage() {
    postImage = null;

    emit(SocialRemovePostImageState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    posts = [];
    postsId = [];
    likes = [];
    emit(SocialGetPostsLoadingState());

    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        postsId.add(element.id);
        element.reference.collection('likes').get().then((value) {
          if (value.docs.isEmpty) {
            likes.add(0);
          } else {
            likes.add(value.docs.length);
          }
        }).catchError((error) {});
        posts.add(PostModel.fromJson(element.data()));
      }
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uid)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState());
    });
  }

  List<SocialUserModel> users = [];

  void getAllUsers() {
    users = [];
    emit(SocialGetAllUserLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element.data()['uid'] != userModel!.uid) {
          users.add(SocialUserModel.fromJson(element.data()));
        }
      }
      emit(SocialGetAllUserSuccessState());
    }).catchError((error) {
      emit(SocialGetAllUserErrorState(error.toString()));
    });
  }

  void send_message({
    required String receverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      sendId: userModel!.uid,
      receverId: receverId,
      dateTime: dateTime,
      text: text,
    );
// set my chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receverId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
// set he chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receverId)
        .collection('chats')
        .doc(userModel!.uid)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> message = [];

  void getMessage({
    required String receverId,
  }) {
    message = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        message.add(
          MessageModel.fromJson(
            element.data(),
          ),
        );
      });
      emit(GetMessageSuccessState());
    });
  }
}
