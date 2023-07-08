import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Bloc/SocialCubit/social_bloc.dart';
import 'package:social_app/Bloc/SocialCubit/social_states.dart';
import 'package:social_app/Components/shortucts.dart';
import 'package:social_app/models/models.dart';
import 'package:social_app/screens/HomeScreens/chat_details/chat_details_screen.dart';

class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: SocialCubit.get(context).users.isNotEmpty ,
            builder: (context)=>ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildChatItem(context, SocialCubit.get(context).users[index]),
              separatorBuilder: (context, index) => Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
              itemCount: SocialCubit.get(context).users.length,
            ),
            fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget buildChatItem(context, SocialUserModel user) => InkWell(
        onTap: ()
        {
          NavTo(context, ChatDetailsScreen(user));
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 30,
                backgroundImage: NetworkImage(
                    user.profile),
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
                          user.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
