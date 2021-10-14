import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_task/config/route/const_route.dart';
import 'package:todo_task/presention/widget/custom_button.dart';
import 'package:todo_task/presention/widget/custom_text_field.dart';

import '../../../../data/datasources/remot/sign_mail_firebase.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _visibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(top: 50),
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(42),
            topRight: Radius.circular(42),
          ),
          color: Theme.of(context).primaryColor,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Form(
              key: _formState,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CustomTextField(
                    controller: _emailController,
                    textType: TextInputType.emailAddress,
                    label: 'Email Address',
                    prefixIcon: const Icon(Icons.email),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'This field should not be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    textType: TextInputType.text,
                    visibility: _visibility,
                    label: 'Password',
                    prefixIcon: const Icon(Icons.security),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'This field should not be empty';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        _visibility ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _visibility = !_visibility;
                        });
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      child: const Text('Forget Password?'),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    CustomButton(
                      title: 'Sign In',
                      onClick: () async {
                        if (_formState.currentState.validate()) {
                          setState(() {
                            _isLoading = !_isLoading;
                          });
                          final user = await signInFirebase();
                          if (user != null) {
                            return Navigator.of(context)
                                .pushNamedAndRemoveUntil(
                              bottomNav,
                              (route) => false,
                            );
                          } else {
                            setState(() {
                              _isLoading = !_isLoading;
                            });
                          }
                        }
                      },
                      color: Colors.deepPurpleAccent.shade200,
                    ),
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'I\'m a new user.',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        child: const Text('Sign Up'),
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(signUp);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<UserCredential> signInFirebase() async {
    return await SignMailFirebase().signIn(
      _emailController.text,
      _passwordController.text,
    );
  }
}
