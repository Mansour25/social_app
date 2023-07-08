import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Bloc/SocialCubit/social_bloc.dart';
import 'package:social_app/Helper/cach_helper.dart';
import 'package:social_app/screens/Home_Screens/home.dart';
import 'package:social_app/screens/login_screen.dart';
import 'Bloc/bloc_observer.dart';
import 'Components/shortucts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CachHelper.init();
  Widget InitialWidget = LoginScreen();
  // CachHelper.deleteData(uid);
  uid = CachHelper.getStringData(key: 'uid');
  print('uid : $uid');
  // FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //   // CachHelper.deleteData('uid');
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     InitialWidget = SocialHome();
  //     print('User is signed in!');
  //   }
  // });
  if (uid.isEmpty == false) {
    InitialWidget = SocialHome();
    print("uid is Not Empty");
  }
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(InitialWidget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget staer_widget;

  MyApp(this.staer_widget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SocialCubit()
            ..getData()
            ..getPosts()
            ..getAllUsers(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: staer_widget,
      ),
    );
  }
}
