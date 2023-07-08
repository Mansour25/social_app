import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:social_app/Bloc/SocialCubit/social_bloc.dart';
import 'package:social_app/Bloc/SocialCubit/social_states.dart';
import 'package:social_app/Components/default.dart';
import 'package:social_app/Components/shortucts.dart';
import 'package:social_app/Helper/cach_helper.dart';
import 'package:social_app/screens/others/new_post.dart';
import 'package:social_app/screens/login_screen.dart';

class SocialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialInitialState) {
          SocialCubit.get(context).getData();
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          backgroundColor: Color(0xFFCDDDFF),
          appBar: AppBar(
            backgroundColor: Color(0xFF05173C),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      CachHelper.deleteData('uid');
                      NavAndFinished(context, LoginScreen());
                    });
                  },
                  icon: Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  )),
            ],
            elevation: 0,
            title: Text(
              // 'بسم الله',
              cubit.title[cubit.currentIndex],
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontFamily: 'PTSerif',
                fontWeight: FontWeight.w700,
              ),
            ),
            // centerTitle: true,
          ),
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).userModel != null,
            fallback: (context) => Padding(
              padding: EdgeInsetsDirectional.only(
                start: 30,
                end: 30,
              ),
              child: LinearProgressIndicator(),
            ),
            builder: (context) {
              var model = SocialCubit.get(context).userModel;
              return cubit.Screens[cubit.currentIndex];
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              NavTo(context, NewPostScreen());
            },
            //params
            backgroundColor: Colors.amber,
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            elevation: 10,
            splashSpeedInMilliseconds: 500,
            notchMargin: 10,
            // gapWidth: 40,
            // height: 60,
            splashColor: Colors.amberAccent[200],
            iconSize: 25,
            // notchAndCornersAnimation:  ,
            splashRadius: 10,
            icons: cubit.icons,
            activeIndex: cubit.currentIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.values[1],
            leftCornerRadius: 30,
            rightCornerRadius: 30,
            inactiveColor: Colors.white,
            activeColor: Colors.amber,
            backgroundColor: Colors.black,
            onTap: (index) => cubit.change_index(index),
            //other params
          ),
        );
      },
    );
  }
}
/*
Container(
            // height: 100,
            child: DotNavigationBar(
              margin: EdgeInsets.only(top: 0),
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.change_index(index);
              },

              backgroundColor: Color(0xFF05173C),
              unselectedItemColor: Color(0xFFF8F9F9),
              // dotIndicatorColor: Colors.white,
              // enableFloatingNavBar: false,
              selectedItemColor: Colors.white,
              // itemPadding: EdgeInsets.,
              paddingR: EdgeInsets.all(5),
              items: cubit.items2,
              // itemPadding: EdgeInsets.,
              // enableFloatingNavBar: ,
              curve: Curves.linearToEaseOut,
              // borderRadius: 0,
              dotIndicatorColor: Colors.white,
              // itemPadding: EdgeInsets.only(bottom: 10),
              duration: Duration(milliseconds: 500),
            ),
          ),
 */

/*
WaterDropNavBar(
            barItems: cubit.items,
            onItemSelected: (index) {
              print(index);
              cubit.change_index(index);
            },
            selectedIndex: cubit.currentIndex,
          ),
 */

/*
RoundedTabbarWidget(
            tabIcons: cubit.icons3,
            pages: cubit.Screens,
            selectedIndex: cubit.currentIndex,
            onTabItemIndexChanged: (int index) {
              print('Index: $index');
              cubit.change_index(index);
            },
          ),

 */
/*
RoundedTabbarWidget(
            tabIcons: cubit.icons32,
            pages: cubit.Screens,
            selectedIndex: cubit.currentIndex,
            onTabItemIndexChanged: (int index) {
              print('Index: $index');
              cubit.change_index(index);
            },
          ),
 */

/*
CurvedNavigationBar(
            backgroundColor:
            Color(0xFFCDDDFF).withOpacity(0.000001),
            animationCurve: Curves.linearToEaseOut,
            items: cubit.icons3,
            index: cubit.currentIndex,
            onTap: (index) {
              cubit.change_index(index);
              //Handle button tap
            },
          ),
 */
