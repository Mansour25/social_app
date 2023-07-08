import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Bloc/SocialCubit/social_bloc.dart';
import 'package:social_app/Bloc/SocialCubit/social_states.dart';
import 'package:social_app/Components/default.dart';
import 'package:social_app/models/post_model.dart';

class Feeds extends StatelessWidget {
  String url =
      'https://img.freepik.com/free-photo/attractive-young-man-t-shirt-yellow-background_185193-74339.jpg?w=900';
  String avatar =
      'https://img.freepik.com/free-photo/excited-handsome-young-man-smiling-pointing-looking-happy-upper-left-corner-empty-space-showing-logo-brand-sale-standing-white-background_176420-46913.jpg?w=1060';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty && SocialCubit.get(context).userModel != null,
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.only(
                    top: 10,
                    bottom: 5,
                    left: 10,
                    right: 10,
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      SizedBox(
                          height: 260,
                          child: Center(child: NetImage(url: url))),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          bottom: 20,
                          end: 10,
                        ),
                        child: Text(
                          'Communicate with friends',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'RobotoCondensed',
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildPostItem(
                        context, index, SocialCubit.get(context).posts[index]);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 1,
                      width: double.infinity,
                    );
                  },
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPostItem(context, int index, PostModel model) => Card(
        elevation: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.only(
          top: 6,
          left: 10,
          right: 10,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 20,
                    backgroundImage: NetworkImage(model.profile),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              model.name,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 14,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          model.dateTime,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                height: 1.3,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz_outlined,
                      size: 20,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[400],
                ),
              ),
              Text(
                model.text,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      height: 2,
                      fontSize: 18,
                    ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        end: 8,
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          '# Software',
                          style: TextStyle(
                            height: 2,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        end: 8,
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          '# Flutter',
                          style: TextStyle(
                            height: 2,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Container(
                    height: 140,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: NetworkImage(model.postImage),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  top: 0,
                  start: 15,
                  end: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite_outline,
                              size: 20,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            // ${SocialCubit.get(context).likes[index]}
                            // if (SocialCubit.get(context).likes[index] != 0 )
                            Text(
                              "10",
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.mode_comment_outlined,
                              size: 20,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "0 comments",
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 1,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                        SocialCubit.get(context).userModel!.profile),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsetsDirectional.only(
                          start: 15,
                        ),
                        child: Text(
                          'write a comment ...',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                height: 3,
                              ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: ()
                        {
                          SocialCubit.get(context)
                              .likePost(SocialCubit.get(context).postsId[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(),
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite_outline,
                                size: 18,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Like",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
