import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar customAppBar() {
  return AppBar(
    leading: BackButton(),
    elevation: 0,
    backgroundColor: Color.fromRGBO(0, 121, 107, 1),
  );
}