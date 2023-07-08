import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Bloc/SocialCubit/social_bloc.dart';
import 'package:social_app/Bloc/SocialCubit/social_states.dart';
import 'package:social_app/Components/default.dart';
import 'dart:core';

import 'package:social_app/Components/shortucts.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController bioController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          if (state is SocialUpdateProfileLoadingState || state is SocialUpdateCoverLoadingState)
            toast('Please Wating ...');
        },
        builder: (context, state) {
          var userModel = SocialCubit.get(context).userModel;
          var profileImage = SocialCubit.get(context).ProfileImage;
          var coverImage = SocialCubit.get(context).CoverImage;
          nameController.text = userModel!.name;
          bioController.text = userModel.bio;
          phoneController.text = userModel.phone;

          return Scaffold(
            backgroundColor: Color(0xFFCDDDFF),
            appBar: AppBar(
              titleSpacing: 3,
              elevation: 0,
              backgroundColor: Color(0xFFCDDDFF),
              title: Text(
                "Edit  Profile",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                  fontFamily: 'Almarai',
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    SocialCubit.get(context).updateUserData(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                    );
                  },
                  child: Text(
                    "UPDATE",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      if (state is SocialUpdateProfileLoadingState || state is SocialUpdateCoverLoadingState )
                        Column(
                          children: [
                            LinearProgressIndicator(),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 190,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              child: InkWell(
                                onTap: () {
                                  SocialCubit.get(context).getCoverImage();
                                  print("Edit Cover");
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 140,
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: coverImage == null
                                              ? NetworkImage(userModel.cover)
                                              : Image.file(coverImage).image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 140,
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.black.withOpacity(0.47),
                                      ),
                                      child: Transform(
                                        transform: Matrix4.translationValues(
                                            0, -30, 0),
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          size: 35,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              alignment: AlignmentDirectional.topCenter,
                            ),
                            InkWell(
                              onTap: () {
                                print("Edit Profile");
                                SocialCubit.get(context).getProfileImage();
                              },
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 53,
                                    backgroundColor: Colors.blue,
                                    child: CircleAvatar(
                                      radius: 50,
                                      // ignore: unnecessary_null_comparison
                                      backgroundImage: profileImage == null
                                          ? NetworkImage(userModel.profile)
                                          : Image.file(profileImage).image,
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 53,
                                    backgroundColor:
                                        Colors.black.withOpacity(0.45),
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 32,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (coverImage != null || profileImage != null)
                        Row(
                          children: [
                            if (profileImage != null)
                              Expanded(
                                  child: Column(
                                children: [
                                  defaultbutton(
                                      double.infinity,
                                      35,
                                      "Save New Profile",
                                      Colors.blueAccent,
                                      Colors.white,
                                      18, () {
                                    SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  }),
                                  if (state is SocialUpdateProfileLoadingState)
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 8,
                                        ),
                                        LinearProgressIndicator(),
                                      ],
                                    ),
                                ],
                              )),
                            SizedBox(
                              width: 15,
                            ),
                            if (coverImage != null)
                              Expanded(
                                  child: Column(
                                children: [
                                  defaultbutton(
                                      double.infinity,
                                      35,
                                      "Save New Cover",
                                      Colors.blueAccent,
                                      Colors.white,
                                      18, () {
                                    SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  }),
                                  if (state is SocialUpdateCoverLoadingState)
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 8,
                                        ),
                                        LinearProgressIndicator(),
                                      ],
                                    ),
                                ],
                              )),
                          ],
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {},
                          // onFieldSubmitted: (value) {
                          //   print(value);
                          // },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: 'Name',
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'name must not be empty !';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {},
                          // onFieldSubmitted: (value) {
                          //   print(value);
                          // },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            labelText: 'Phone',
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'phone must not be empty !';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          controller: bioController,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {},
                          // onFieldSubmitted: (value) {
                          //   print(value);
                          // },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.info_outline),
                            labelText: 'Bio',
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'bio must not be empty !';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
