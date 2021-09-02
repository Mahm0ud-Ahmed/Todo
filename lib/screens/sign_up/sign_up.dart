import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/screens/layout/home_screen/home_screen.dart';
import 'package:todo_task/screens/layout/sign/sign_controller.dart';
import 'package:todo_task/screens/sign_in/bloc/sign_in_cubit.dart';
import 'package:todo_task/screens/sign_in/sign_in.dart';
import 'package:todo_task/shared/component/components.dart';
import 'package:todo_task/shared/network/local/todo_app_state.dart';

class SignUp extends StatefulWidget {
  static const String SIGN_UP = 'signUpScreen';

  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  GlobalKey<FormState> _formState = GlobalKey<FormState>();

  SignInCubit _cubit;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
  }

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
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: Form(
                    key: _formState,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        customTextField(
                            controller: _nameController,
                            textType: TextInputType.text,
                            label: 'Full Name',
                            prefixIcon: Icon(Icons.drive_file_rename_outline),
                            validator: (String val) {
                              if (val.isEmpty) {
                                return 'This field should not be empty';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        customTextField(
                          controller: _phoneController,
                          textType: TextInputType.phone,
                          label: 'Phone Number',
                          prefixIcon: Icon(Icons.phone_android),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        customTextField(
                            controller: _emailController,
                            textType: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefixIcon: Icon(Icons.email),
                            validator: (String val) {
                              if (val.isEmpty) {
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
                            label: 'Password',
                            visibility: _cubit.visibility,
                            prefixIcon: Icon(Icons.security),
                            suffixIcon: IconButton(
                              icon: Icon(_cubit.visibility
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                _cubit.changeVisibility();
                              },
                            ),
                            validator: (String val) {
                              if (val.isEmpty) {
                                return 'This field should not be empty';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 40,
                        ),
                        customButton(
                          title: 'Sign Up',
                          context: context,
                          onClick: () {
                            if (_formState.currentState.validate()) {
                              /*signUpProvider.setMail(_emailController.text);
                              signUpProvider.setPassword(
                                  _passwordController.text);*/
                              SignController.signUp(_emailController.text,
                                  _passwordController.text)
                                  .then((value) {
                                if (value != null) {
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
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'I\'m a already a member.',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextButton(
                              child: Text('Sign In'),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(SignIn.SIGN_IN);
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
