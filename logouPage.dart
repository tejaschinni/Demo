import 'package:caloriecounter/signInPage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogoutPage extends StatefulWidget {
  Function sigOut;
  GoogleSignInAccount gUser;
  Function read;
  DateTime date;
  LogoutPage(this.gUser, this.sigOut, this.read, this.date);

  @override
  _LogoutPageState createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            child: InkWell(
              child: Icon(Icons.person),
              onTap: () {
                widget.sigOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (contex) => SigInPage()));
              },
            ),
          )
        ],
      ),
      body: Container(
        child: Text(widget.date.toString()),
      ),
    );
  }
}
