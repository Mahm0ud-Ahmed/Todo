import 'package:flutter/material.dart';
import 'package:todo_task/screens/sign_in/sign_in.dart';
import 'package:todo_task/screens/sign_up/sign_up.dart';

class Sign extends StatelessWidget {
  static const String SIGN = 'sign';

  const Sign({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Task App',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(18),
                margin: const EdgeInsets.symmetric(vertical: 18),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 60,
                      color: Colors.white.withOpacity(1),
                    ),
                  ],
                  color: Colors.grey.shade300,
                  image: DecorationImage(
                    image: AssetImage('assets/images/sign.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignUp.SIGN_UP);
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepPurpleAccent.shade200),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      )),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 45,
                margin: const EdgeInsets.symmetric(vertical: 24),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignIn.SIGN_IN);
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(
                        width: 1.5,
                        color: Colors.grey,
                      ),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
