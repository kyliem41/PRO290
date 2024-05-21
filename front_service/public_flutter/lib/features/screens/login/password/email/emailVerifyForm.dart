import 'package:flutter/material.dart';
import 'package:frontend/features/screens/login/password/pass/forgotPass.dart';
import 'package:frontend/scripts/login.dart';

class EmailVerifyForm extends StatelessWidget {
  EmailVerifyForm({
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
          height: 200,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.fingerprint),
                  labelText: AutofillHints.oneTimeCode,
                  hintText: 'code',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPass()),
                      );
                    },
                    child: Text('SEND CODE')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
