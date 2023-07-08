import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Bloc/login_cubit/login_states.dart';
import 'package:social_app/Bloc/register_cubit/register_cubit.dart';
import 'package:social_app/Bloc/register_cubit/register_states.dart';
import 'package:social_app/Components/default.dart';
import 'package:social_app/Components/shortucts.dart';
import 'package:social_app/Helper/cach_helper.dart';
import 'package:social_app/screens/Home_Screens/home.dart';

class SocialRigesterScreen extends StatefulWidget {
  // const ShopLoginScreen({Key? key}) : super(key: key);
  @override
  State<SocialRigesterScreen> createState() => _SocialRigesterScreenState();
}

class _SocialRigesterScreenState extends State<SocialRigesterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formkey = GlobalKey<FormState>();
  var _isObscure = true;
  var iconobscure = Icons.remove_red_eye_rounded;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterState>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            CachHelper.saveData(key: 'uid', value: state.uid).then((value) {
              print(
                  "Success Success SuccessSuccessSuccessSuccessSuccess Success Success Success Success Success ");
              print("CachHelper Success Saved");
              print(state.uid);
              uid = state.uid ;
              NavAndFinished(context, SocialHome());
            });
          }
          if (state is SocialRegisterErrorState)
            {
              print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
              print(state.error);
              print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
            }
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is SocialRegisterLoadingState,
            fallback: (context) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'REGISTER',
                              style: TextStyle(fontSize: 40),
                            ),
                            Text(
                              'Register now to browser our hot offers',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            defaultFormField(
                              controller: nameController,
                              label: 'Name',
                              onChange: () {},
                              onTap: () {},
                              prefix: Icons.person,
                              type: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Enter Your Name';
                                } else {
                                  return '';
                                }
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                              controller: emailController,
                              label: 'Email Address',
                              onChange: () {},
                              onTap: () {},
                              prefix: Icons.email,
                              type: TextInputType.emailAddress,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Enter Your Email Adress';
                                } else {
                                  return '';
                                }
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              onTap: () {},
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              onChanged: (value) {},
                              obscureText: _isObscure,
                              onFieldSubmitted: (value) {
                                print(value);
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                                prefixIcon: Icon(Icons.lock_outline),
                                labelText: 'Password',
                                border: const OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Form must not be empty !';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            defaultFormField(
                              controller: phoneController,
                              label: 'Phone',
                              onChange: () {},
                              onTap: () {},
                              prefix: Icons.phone,
                              type: TextInputType.phone,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Enter Your Phone';
                                } else {
                                  return '';
                                }
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            defaultbutton(
                              double.infinity,
                              60,
                              "Register",
                              Colors.deepOrange,
                              Colors.white,
                              22,
                              () {
                                if (formkey.currentState!.validate()) {
                                  SocialRegisterCubit.get(context).UserRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            builder: (context) {
              return Scaffold(
                backgroundColor: Colors.black45,
                body: Center(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 30,
                      end: 30,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Registering ... ☺",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        LinearProgressIndicator(),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
