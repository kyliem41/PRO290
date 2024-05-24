import 'package:flutter/material.dart';
import 'package:frontend/features/screens/createUser/createUserForm.dart';

class CreateUserPage extends StatelessWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal.shade100,
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome!',
                    style: Theme.of(context).textTheme.headlineLarge),
                SizedBox(height: 20),
                createUserForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
