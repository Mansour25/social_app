import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Bloc/SocialCubit/social_bloc.dart';
import 'package:social_app/Bloc/SocialCubit/social_states.dart';
import 'package:social_app/Components/shortucts.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var postImage = SocialCubit.get(context).postImage;
    String avatar =
        'https://img.freepik.com/free-photo/excited-handsome-young-man-smiling-pointing-looking-happy-upper-left-corner-empty-space-showing-logo-brand-sale-standing-white-background_176420-46913.jpg?w=1060';
    TextEditingController textController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state)
      {
        if (state is SocialCreatePostLoadingState )
          {
            toast('Please Wating ...');
          }
        if (state is SocialCreatePostSuccessState)
          {
            Navigator.pop(context);
          }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          backgroundColor: Color(0xFFCDDDFF),
          appBar: AppBar(
            titleSpacing: 3,
            elevation: 0,
            backgroundColor: Color(0xFFCDDDFF),
            title: Text(
              "Create Post",
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
                  if (SocialCubit.get(context).postImage != null) {
                    SocialCubit.get(context).upload_post_image(
                      dateTime: DateTime.now().toString(),
                      text: textController.text,
                    );
                  } else {
                    SocialCubit.get(context).CreateNewPost(
                      dateTime: DateTime.now().toString(),
                      text: textController.text,
                    );
                  }
                },
                child: Text(
                  "Post",
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      LinearProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 30,
                      backgroundImage: NetworkImage(avatar),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "Mohammed Mansour",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'what is on your mind ...',
                        border: InputBorder.none),
                  ),
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    children: [
                      Container(
                        height: 140,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image:
                                FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          SocialCubit.get(context).removePostImage();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 140,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black.withOpacity(0.3),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.close,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/add-photo.png',
                              height: 30,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'add photo',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "# tags",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
