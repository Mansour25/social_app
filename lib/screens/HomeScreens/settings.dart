import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Bloc/SocialCubit/social_bloc.dart';
import 'package:social_app/Bloc/SocialCubit/social_states.dart';
import 'package:social_app/Components/default.dart';
import 'package:social_app/Components/shortucts.dart';
import 'package:social_app/screens/others/edit_profie.dart';

class Settingss extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String avatar =
        'https://img.freepik.com/foto-gratis/hombre-joven-barba-camiseta-blanca-cara-feliz-sonriendo-confianza-mostrando-senalando-dedos-dientes-boca_94120-767.jpg?w=1060';
    String bacimg =
        'https://img.freepik.com/free-photo/young-man-with-beard-white-t-shirt-happy-face-smiling-with-happy-face-looking-pointing-side-with-thumb-up_94120-769.jpg?w=1380';
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      child: Container(
                        height: 140,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(userModel!.cover),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    CircleAvatar(
                      radius: 53,
                      backgroundColor: Colors.blue,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(userModel.profile),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${userModel.name}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${userModel.bio}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Row(
                  children: [
                    underBio(context, '230', 'posts'),
                    underBio(context, '163', 'photos'),
                    underBio(context, '10K', 'followers'),
                    underBio(context, '230', 'following'),
                  ],
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        "Add Photos",
                        style: TextStyle(
                          fontFamily: 'Almarai',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      NavTo(context, EditProfile());
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              // defaultbutton(double.infinity, 40, 'Edit Profile',
              //     Colors.amber.withOpacity(0.6), Colors.black, 22, () {}),
            ],
          ),
        );
      },
    );
  }

  Widget underBio(context, String num, String name) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Text(
              "${num}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '${name}',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
