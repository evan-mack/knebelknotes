import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';


class TOSPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Terms Of Use'), centerTitle: true),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10
          ),
          child: FutureBuilder(
            future: _loadEULA(),
            builder: (context, AsyncSnapshot<String> snapshot) {
              if(!snapshot.hasData){
                return Center(child:CircularProgressIndicator());
              }
              else
                return Text(snapshot.data);
            },
          )
        )
      ),
    );
  }

}

Future<String> _loadEULA() async {
  return await rootBundle.loadString('assets/EULA.rtf');
}