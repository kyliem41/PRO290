import 'package:flutter/material.dart';
import 'package:frontend/features/screens/login/password/email/emailVerify.dart';
import 'package:frontend/scripts/login.dart';

class GetEmailForm extends StatelessWidget {
  GetEmailForm({
    super.key,
  });

  final TextEditingController _emailController = TextEditingController();
  final loginService = LoginService();

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
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.fingerprint),
                  labelText: AutofillHints.email,
                  hintText: 'email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      if(await loginService.doesEmailExist(_emailController.text)){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => EmailVerify()),
                        );
                      }
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
