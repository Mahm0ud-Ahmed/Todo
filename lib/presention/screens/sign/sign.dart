import 'package:flutter/material.dart';
import 'package:todo_task/config/route/const_route.dart';

class Sign extends StatelessWidget {
  const Sign({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
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
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Colors.white.withOpacity(1),
                    ),
                  ],
                  image: const DecorationImage(
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
                    Navigator.of(context).pushNamed(signUp);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurpleAccent.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 45,
                margin: const EdgeInsets.symmetric(vertical: 24),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(signIn);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      width: 1.5,
                      color: Colors.grey,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
