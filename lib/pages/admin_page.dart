import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:knebelknotes/services/database.dart';

class AdminPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AdminPageState();
}

class AdminPageState extends State<AdminPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _controller = new TextEditingController();

  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Clear',
        onPressed: () {
          setState(() {
            _email = '';
            _controller.clear();
            _student = false;
            _admin = false;
          });
        },
      ),
    ));
  }

  var acs = ActionCodeSettings(
      url: 'https://knebelknotes.page.link/invite',
      androidPackageName: 'com.flutter.knebelknotes',
      androidInstallApp: true,
      handleCodeInApp: true,
      androidMinimumVersion: '12');

  String _email = '';
  bool _student = false;
  DateTime _accessExpires = DateTime.now();
  bool _admin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Admin'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Form(
          child: Column(
            children: <Widget>[
              Text('Add or Update a user'),
              TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(hintText: 'Email'),
                  onChanged: (val) {
                    setState(() => _email = val);
                  }),
              SizedBox(height: 20),
              CheckboxListTile(
                value: _student,
                title: Text('Premium/Student'),
                onChanged: (bool val) {
                  setState(() => _student = val);
                },
              ),
              if (_student)
                Text('Access Until ' +
                    _accessExpires.month.toString() +
                    '/' +
                    _accessExpires.day.toString() +
                    '/' +
                    _accessExpires.year.toString()),
              FlatButton(
                  onPressed: () {
                    _student == true
                        ? DatePicker.showDatePicker(context,
                            showTitleActions: true, onChanged: (date) {
                            print('change $date in time zone ' +
                                date.timeZoneOffset.inHours.toString());
                          }, onConfirm: (date) {
                            setState(() => _accessExpires = date);
                          }, currentTime: DateTime.now())
                        : null;
                  },
                  child: Text(
                    'Choose Premium/Student Access End Date',
                    style: TextStyle(
                        color: _student == true ? Colors.blue : Colors.grey),
                  )),
              CheckboxListTile(
                value: _admin,
                title: Text('Admin - Free Access/Add Users'),
                onChanged: (bool val) {
                  setState(() => _admin = val);
                },
              ),
              FlatButton(
                  color: Colors.blue[400],
                  child: Text('Send Email'),
                  onPressed: () {
                    print('sending email to ' + _email);
                    if (_email.length > 1) {
                      try {
                        _auth
                            .sendSignInLinkToEmail(
                                email: _email.toLowerCase().trim(),
                                actionCodeSettings: acs)
                            .catchError((onError) => print(
                                'Error Sending Email' + onError.toString()));
                        //create user on firebase with uid
                        DatabaseService(email: _email.toLowerCase().trim())
                            .updateUserData(
                                _admin, _student, _accessExpires.toString());
                      } on Exception catch (e) {
                        print(e.toString());
                      }
                      _showScaffold('Email Sent');
                    } else {
                      _showScaffold('Invalid email');
                    }
                  }),
              SizedBox(height: 10),
              Text('OR'),
              SizedBox(height: 10),
              FlatButton(
                  color: Colors.blue[400],
                  onPressed: () async {
                    if (_email.length > 1) {
                      await DatabaseService(email: _email.toLowerCase())
                          .updateUserData(
                              _admin, _student, _accessExpires.toString());
                      _showScaffold('User Added/Updated');
                    } else {
                      _showScaffold('Invalid email');
                    }
                  },
                  child: Text('Submit without email'))
            ],
          ),
        ),
      ),
    );
  }
}
