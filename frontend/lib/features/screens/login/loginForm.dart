import 'package:flutter/material.dart';

class LogInForm extends StatelessWidget {
  const LogInForm({
    super.key,
  });

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
          //padding: EdgeInsets.symmetric(vertical: 20),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: AutofillHints.username,
                  hintText: 'username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 35),
              TextFormField(
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
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text('Forgot Password?'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () {}, child: Text('LOG IN')),
              ),
              SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {},
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
