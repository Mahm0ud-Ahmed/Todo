import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/business_logic/todo_cubit.dart';
import 'package:todo_task/bloc/business_logic/todo_state.dart';
import 'package:todo_task/config/route/const_route.dart';
import 'package:todo_task/presention/screens/sign/sign_up/widget/build_item_text_field.dart';
import 'package:todo_task/presention/widget/components.dart';
import 'package:todo_task/presention/widget/custom_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  bool _isLoading = false;

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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocListener<TodoCubit, TodoAppState>(
        listenWhen: (previous, current) {
          return previous != current;
        },
        listener: (context, state) {
          if (state is ErrorSignState) {
            showToast(state.message, Colors.red);
          }
        },
        child: Container(
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
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  BuildItemTextField(
                    formState: _formState,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    nameController: _nameController,
                    phoneController: _phoneController,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    CustomButton(
                      title: 'Sign Up',
                      color: Colors.deepPurpleAccent.shade200,
                      onClick: () async {
                        if (_formState.currentState.validate()) {
                          setState(() {
                            _isLoading = !_isLoading;
                          });
                          final user = await signUpFirebase(context);
                          if (user) {
                            return Navigator.of(context)
                                .pushNamedAndRemoveUntil(
                              signIn,
                              (route) => false,
                            );
                          } else {
                            setState(() {
                              _isLoading = !_isLoading;
                            });
                          }
                        }
                      },
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'I\'m a already a member.',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        child: const Text('Sign In'),
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(signIn);
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

  Future<bool> signUpFirebase(BuildContext context) async {
    return TodoCubit.get(context).signUp(
        email: _emailController.text, password: _passwordController.text);
  }
}
