import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/screens/layout/home_screen/home_screen.dart';
import 'package:todo_task/screens/layout/sign/sign_controller.dart';
import 'package:todo_task/screens/sign_up/sign_up.dart';
import 'package:todo_task/shared/component/components.dart';
import 'package:todo_task/shared/network/local/todo_app_state.dart';

import 'bloc/sign_in_cubit.dart';

class SignIn extends StatefulWidget {
  static const String SIGN_IN = 'signInScreen';

  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formState = GlobalKey<FormState>();

  SignInCubit _cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (context) => SignInCubit(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: BlocConsumer<SignInCubit, TodoAppState>(
          listener: (context, state) {},
          builder: (context, state) {
            _cubit = SignInCubit.get(context);
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(top: 50),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(42),
                  topRight: Radius.circular(42),
                ),
                color: Colors.grey[300],
              ),
              child: SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: _formState,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        customTextField(
                            controller: _emailController,
                            textType: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefixIcon: Icon(Icons.email),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'This field should not be empty';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        customTextField(
                          controller: _passwordController,
                          textType: TextInputType.text,
                          visibility: _cubit.visibility,
                          label: 'Password',
                          prefixIcon: Icon(Icons.security),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'This field should not be empty';
                            }
                            return null;
                          },
                          suffixIcon: IconButton(
                            icon: Icon(_cubit.visibility
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              _cubit.changeVisibility();
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            child: Text('Forget Password?'),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        customButton(
                          title: 'Sign In',
                          context: context,
                          onClick: () {
                            if (_formState.currentState.validate()) {
                              /*signInProvider.setMail(_emailController.text);
                              signInProvider.setPassword(
                                  _passwordController.text);*/
                              SignController.signIn(_emailController.text,
                                      _passwordController.text)
                                  .then((value) {
                                if (value != null) {
                                  print(value.toString());
                                  return Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                          HomeScreen.HOME_MAIN,
                                          (route) => false);
                                }
                                return null;
                              });
                            }
                          },
                          color: Colors.deepPurpleAccent.shade200,
                          radius: 14,
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 50,
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'I\'m a new user.',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextButton(
                              child: Text('Sign Up'),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(SignUp.SIGN_UP);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
