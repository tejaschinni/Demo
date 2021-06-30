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
  bool flag = false;
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
      body: DelayedDisplay(
          delay: Duration(seconds: 1),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('caloriecounter')
                .doc(widget.gUser.email)
                .collection('recipes')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var recipes;

              try {
                recipes = snapshot.data!.docs;

                setState(() {
                  flag = false;
                });
              } catch (e) {
                print("NO DATA");
              }
              if (flag) {
                return Container();
              } else {
                return Column(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: recipes.length == 0
                              ? Container(
                                  child: Center(child: Text('NO DATA Found')))
                              : ListView.builder(
                                  itemCount: recipes.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      child: Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 0.2,
                                                color: Colors.grey)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                    padding: EdgeInsets.all(12),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text: recipes[index]
                                                                ['name']
                                                            .toString(),
                                                        style:
                                                            DefaultTextStyle.of(
                                                                    context)
                                                                .style,
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text: '\n ' +
                                                                  recipes[index]
                                                                          [
                                                                          'grams']
                                                                      .toString() +
                                                                  ' g',
                                                              style:
                                                                  TextStyle()),
                                                        ],
                                                      ),
                                                    ))),
                                            Expanded(
                                              child: Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                padding: EdgeInsets.all(12),
                                                child: RichText(
                                                  textAlign: TextAlign.right,
                                                  text: TextSpan(
                                                    text: recipes[index]
                                                            ['calories']
                                                        .toString(),
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: '\nC: ' +
                                                              recipes[index]
                                                                      ['carbon']
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey)),
                                                      TextSpan(
                                                          text: '\t F: ' +
                                                              recipes[index]
                                                                      ['fats']
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .orange)),
                                                      TextSpan(
                                                          text: '\t P: ' +
                                                              recipes[index][
                                                                      'protiens']
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.red))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (contex) =>
                                                    EditRecipePage(
                                                        widget.gUser,
                                                        widget.signOut,
                                                        recipes[index])));
                                      },
                                    );
                                  }),
                        )),
                  ],
                );
              }
            },
          )),
    );
  }
}
