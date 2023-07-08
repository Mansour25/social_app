import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Bloc/SocialCubit/social_bloc.dart';
import 'package:social_app/Bloc/SocialCubit/social_states.dart';
import 'package:social_app/models/model_chat.dart';
import 'package:social_app/models/models.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel userModel;

  ChatDetailsScreen(this.userModel);

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      SocialCubit.get(context).getMessage(receverId: userModel.uid);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color(0xFFCDDDFF),
            appBar: AppBar(
              titleSpacing: 3,
              elevation: 0,
              backgroundColor: Color(0xFFCDDDFF),
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(userModel.profile),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    userModel.name,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
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
            ),
            body: ConditionalBuilder(
              condition: true,
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          MessageModel message =
                              SocialCubit.get(context).message[index];

                          if (SocialCubit.get(context).userModel!.uid ==
                              message.sendId) {
                            return buildMyMessage(message);
                          } else {
                            return buildMessage(message);
                          }
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: SocialCubit.get(context).message.length,
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: textController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type your message ...',
                              ),
                            ),
                          ),
                          MaterialButton(
                            minWidth: 1,
                            onPressed: () {
                              SocialCubit.get(context).send_message(
                                receverId: userModel.uid,
                                dateTime: DateTime.now().toString(),
                                text: textController.text,
                              );
                              textController.text = '';
                            },
                            child: Icon(
                              Icons.send,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          margin: EdgeInsetsDirectional.only(
            bottom: 10,
            end: 50,
          ),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                bottomStart: Radius.circular(10),
              )),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(
            model.text,
            style: TextStyle(
              fontSize: 16,
              height: 1.4,
              fontFamily: 'Almarai',
              // letterSpacing: 1
            ),
          ),
        ),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            margin: EdgeInsetsDirectional.only(
              top: 10,
              start: 50,
            ),
            decoration: BoxDecoration(
                color: Colors.amber[300],
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                )),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              model.text,
              style: TextStyle(
                fontSize: 16,
                height: 1.4,
                fontFamily: 'Almarai',
                // letterSpacing: 1
              ),
              textAlign: TextAlign.start,
            )),
      );
}
