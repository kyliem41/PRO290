import 'package:flutter/material.dart';
import '../home/homeScreen.dart';
import '../login/loginScreen.dart';
import '../../../main.dart';
import '../../../scripts/create_account.dart';

class createUserForm extends StatelessWidget {
  createUserForm({
    super.key,
  });
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController = TextEditingController();

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
              ),
              SizedBox(height: 35),
              TextFormField(
                controller: _passwordController,
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
              ),
              SizedBox(height: 35),
              TextFormField(
                controller: _passwordConfirmationController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.fingerprint),
                  labelText: AutofillHints.password,
                  hintText: 'confirm password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: null,
                    icon: Icon(Icons.remove_red_eye_sharp),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      //TODOS: if creation successful, if not give error message
                      String usernameError = await validateUsername(_usernameController.text);
                      if (usernameError.isEmpty) {
                        String emailError = await validateEmail(_emailController.text);
                        if (emailError.isEmpty) {
                          String passwordError = validatePassword(_passwordController.text, _passwordConfirmationController.text);
                          if (passwordError.isEmpty) {
                            int statusCode = await createAccount(_usernameController.text, "", _emailController.text, _passwordConfirmationController.text);
                            if (statusCode == 201) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MyHomePage()),
                              );
                            }
                          }
                        }
                      }
                      String emailError = await validateEmail(_emailController.text);
                      String passwordError = validatePassword(_passwordController.text, _passwordConfirmationController.text);
                      
                      print(usernameError);
                      print(emailError);
                      print(passwordError);
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
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
          });
        }
      },
      controller: TextEditingController(
        text: _selectedDate != null ? _selectedDate.toString() : '',
      ),
    );
  }
}
