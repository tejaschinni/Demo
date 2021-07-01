import 'package:caloriecounter/caloriecounter/editRecipePage.dart';
import 'package:caloriecounter/signInPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ViewRecipePage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  ViewRecipePage(this.gUser, this.signOut);

  @override
  _ViewRecipePageState createState() => _ViewRecipePageState();
}

class _ViewRecipePageState extends State<ViewRecipePage> {
  CollectionReference firestore =
      FirebaseFirestore.instance.collection('caloriecounter');
  bool flag = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('View Recipes'),
          actions: [
            Center(
              child: Container(
                child: InkWell(
                  child: Icon(Icons.person),
                  onTap: () {
                    widget.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (contex) => SigInPage()));
                  },
                ),
              ),
            )
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('caloriecounter')
              .doc(widget.gUser.email)
              .collection('recipes')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return new Text('Loading...');
            return new ListView(
              children: snapshot.data!.docs.map((document) {
                return InkWell(
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: new ListTile(
                      title: Text(document['name'].toString()),
                      subtitle: Text(document['grams'].toString()),
                    ),
                  ),
                  onTap: () {
                    print(document.reference.id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => EditRecipePage(
                                widget.gUser,
                                widget.signOut,
                                document,
                                document.reference.id)));
                  },
                );
              }).toList(),
            );
          },
        ));
  }
}
