import 'package:flutter/material.dart';
import 'package:frontend/features/screens/createUser/createUser.dart';
import 'package:frontend/features/screens/home/homeScreen.dart';
import 'package:frontend/features/screens/login/password/email/getEmail.dart';

class LogInForm extends StatefulWidget {
  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _usernameController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passController.dispose();
    super.dispose();
  }

  bool get userValid {
    return _usernameController.text.isNotEmpty &&
        _passController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Container(
          width: 900,
          height: 350,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: AutofillHints.username,
                  hintText: 'username',
                  border: OutlineInputBorder(),
                ),
                // onChanged: (value) {
                //   setState(() {
                //     _usernameController.text = value;
                //     print('user: $value');
                //   });
                // },
              ),
              SizedBox(height: 35),
              TextFormField(
                controller: _passController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.fingerprint),
                  labelText: AutofillHints.password,
                  hintText: 'password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: null,
                    icon: Icon(Icons.remove_red_eye_sharp),
                  ),
                ),
                obscureText: true,
                // onChanged: (value) {
                //   setState(() {
                //     _passController.text = value;
                //     print('pass: $value');
                //   });
                // },
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GetEmail(),
                      ),
                    );
                  },
                  child: Text('Forgot Password?'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      //TODOS: if login successful, if not give error message
                      if (userValid) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                    'Something went wrong. Please try again.'),
                                contentTextStyle: TextStyle(color: Colors.blue),
                              );
                            });
                      }
                    },
                    child: Text('LOG IN')),
              ),
              SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateUserPage()),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account?",
                      style: Theme.of(context).textTheme.bodySmall,
                      children: [
                        TextSpan(
                          text: ' Sign up!',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
