import 'package:flutter/material.dart';
import 'package:frontend/features/screens/home/homeScreen.dart';
import 'package:frontend/features/screens/login/loginScreen.dart';

class createUserForm extends StatefulWidget {
  @override
  _createUserFormState createState() => _createUserFormState();
}

class _createUserFormState extends State<createUserForm> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _repassController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _repassController.dispose();
    super.dispose();
  }

  bool get userValid {
    return _usernameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passController.text.isNotEmpty &&
        _repassController.text.isNotEmpty &&
        _passController.text == _repassController.text;
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
          height: 600,
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
              const DOBInput(),
              SizedBox(height: 35),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: AutofillHints.email,
                  hintText: 'email',
                  border: OutlineInputBorder(),
                ),
                // onChanged: (value) {
                //   setState(() {
                //     _emailController.text = value;
                //     print('email: $value');
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
                // onChanged: (value) {
                //   setState(() {
                //     _passController.text = value;
                //     print('pass: $value');
                //   });
                // },
              ),
              SizedBox(height: 35),
              TextFormField(
                controller: _repassController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.fingerprint),
                  labelText: AutofillHints.password,
                  hintText: 'confirm password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.remove_red_eye_sharp),
                  ),
                ),
                // onChanged: (value) {
                //   setState(() {
                //     _repassController.text = value;
                //     print('repass: $value');
                //   });
                // },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      //TODOS: if creation successful, if not give error message
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
                    child: Text('SIGN UP')),
              ),
              SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogInPage()),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Already have an account?",
                      style: Theme.of(context).textTheme.bodySmall,
                      children: [
                        TextSpan(
                          text: ' Log In!',
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

class DOBInput extends StatefulWidget {
  const DOBInput({Key? key}) : super(key: key);

  @override
  _DOBInputState createState() => _DOBInputState();
}

class _DOBInputState extends State<DOBInput> {
  DateTime? _selectedDate;
  final _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _dateController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.calendar_today),
        labelText: 'DOB',
        hintText: 'date of birth',
        border: OutlineInputBorder(),
      ),
      readOnly: true,
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1960),
          lastDate: DateTime(2050),
        );
        if (pickedDate != null && pickedDate != _selectedDate) {
          setState(() {
            _selectedDate = pickedDate;
            _dateController.text = _selectedDate.toString().split(' ')[0];
            print('date: $pickedDate');
          });
        }
      },
      // controller: _dateController,
    );
  }
}
