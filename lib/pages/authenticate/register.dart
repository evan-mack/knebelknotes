import 'package:flutter/material.dart';
import 'package:knebelknotes/services/auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up to Knebel Knotes'),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          RaisedButton(
            color: Colors.blue[400],
            child: Text('Register', style: TextStyle(color: Colors.white)),
            onPressed: () async {},
          ),
        ],
      )),
    );
  }
}
