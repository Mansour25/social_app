import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Bloc/login_cubit/login_cubit.dart';
import 'package:social_app/Bloc/login_cubit/login_states.dart';
import 'package:social_app/Components/default.dart';
import 'package:social_app/Components/shortucts.dart';
import 'package:social_app/Helper/cach_helper.dart';
import 'package:social_app/screens/Home_Screens/home.dart';
import 'package:social_app/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    bool _isObscure = true;
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginState>(
        listener: (context, state) {
          if (state is SocialLoginSuccessState) {
            print(state.uid);
            CachHelper.saveData(key: 'uid', value: state.uid).then((value) {
              print(CachHelper.getStringData(key: 'uid'));
              uid = state.uid ;
              toast('تم تسجيل الدخول بنجاح');
              NavAndFinished(context, SocialHome());
            });
          }

          if (state is SocialLoginErrorState)
            {
              toast(state.error.toString());
            }
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is SocialLoginLoadingState,
              builder: (context) =>Scaffold(
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
                          "Signing in ... ☺",
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
              ),
              fallback: (context) => Scaffold(
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
                            'LOGIN',
                            style: TextStyle(fontSize: 40),
                          ),
                          Text(
                            'Login now to browser our hot offers',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                            controller: emailController,
                            label: 'Email Address',
                            onChange: () {},
                            onTap: () {},
                            prefix: Icons.email_outlined,
                            type: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter Your Email Address';
                              } else {
                                return '';
                              }
                            },
                          ),
                          SizedBox(
                            height: 15,
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
                          defaultbutton(
                            double.infinity,
                            60,
                            "LOGIN",
                            Colors.deepOrange,
                            Colors.white,
                            22,
                                () {
                              if (formkey.currentState!.validate()) {
                                SocialLoginCubit.get(context).UserLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don\'t have an account ? ",
                                style: TextStyle(fontSize: 16),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    NavTo(context, SocialRigesterScreen());
                                  },
                                  child: Text(
                                    " REGISTER",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
