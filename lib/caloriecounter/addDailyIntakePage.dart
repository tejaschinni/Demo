import 'package:caloriecounter/caloriecounter/addRecipePage.dart';
import 'package:caloriecounter/caloriecounter/viewPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class AddDailyIntakePage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  DateTime selectedDate;

  AddDailyIntakePage(this.gUser, this.selectedDate, this.signOut);

  @override
  _AddDailyIntakePageState createState() => _AddDailyIntakePageState();
}

class _AddDailyIntakePageState extends State<AddDailyIntakePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController gramsController = TextEditingController();
  TextEditingController carbonController = TextEditingController();
  TextEditingController fatsController = TextEditingController();
  TextEditingController protiensController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();

  CollectionReference collection =
      FirebaseFirestore.instance.collection('caloriecounter');

  String name = ' ';
  int grams = 0,
      carbon = 0,
      fats = 0,
      protiens = 0,
      calories = 0,
      tcab = 0,
      tcal = 0,
      tfat = 0,
      tgram = 0,
      tprot = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Daily Intake' + widget.selectedDate.toString()),
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              child: InkWell(
                child: Icon(Icons.home),
                onTap: () {
                  widget.signOut();
                },
              ),
            )
          ],
        ),
        body: Container(
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text('Recipe Name'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 8, right: 10),
                        child: TextField(
                          controller: nameController,
                          onChanged: (String val) {
                            setState(() {
                              name = val;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text('Grams'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 50, top: 8, right: 10),
                        child: TextField(
                          controller: gramsController,
                          keyboardType: TextInputType.number,
                          onChanged: (String val) {
                            setState(() {
                              grams = int.parse(val);
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text('Carbon'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 50, top: 8, right: 10),
                        child: TextField(
                          controller: carbonController,
                          keyboardType: TextInputType.number,
                          onChanged: (String val) {
                            setState(() {
                              carbon = int.parse(val);
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text('Protiens'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 50, top: 8, right: 10),
                        child: TextField(
                          controller: protiensController,
                          keyboardType: TextInputType.number,
                          onChanged: (String val) {
                            setState(() {
                              protiens = int.parse(val);
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text('Calories'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 50, top: 8, right: 10),
                        child: TextField(
                          controller: caloriesController,
                          keyboardType: TextInputType.number,
                          onChanged: (String val) {
                            setState(() {
                              calories = int.parse(val);
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text('Fat'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 50, top: 8, right: 10),
                        child: TextField(
                          controller: fatsController,
                          keyboardType: TextInputType.number,
                          onChanged: (String val) {
                            setState(() {
                              fats = int.parse(val);
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(5),
                  child: InkWell(
                    child: Text('Add your recipe'),
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ViewRecipesPage()));
                    },
                  ),
                )),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              addFood();
              _read();

              nameController.text = "";
              protiensController.text = "";
              caloriesController.text = "";
              gramsController.text = "";
              fatsController.text = "";
              carbonController.text = "";
              name = "";
              fats = 0;
              grams = 0;
              protiens = 0;
              calories = 0;
              carbon = 0;

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ViewPage(widget.gUser, widget.signOut)));
            });
          },
        ));
  }

  Future<void> addFood() async {
    collection
        .doc(widget.gUser.email)
        .collection('food')
        .doc(widget.selectedDate.toString())
        .collection('meals')
        .doc()
        .set({
      'name': name,
      'fats': fats,
      'grams': grams,
      'protiens': protiens,
      'calories': calories,
      'carbon': carbon
    });
  }

  void _read() async {
    try {
      FirebaseFirestore.instance
          .collection('caloriecounter')
          .doc(widget.gUser.email)
          .collection('food')
          .doc(widget.selectedDate.toString())
          .collection('meals')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          tcab = 0;
          tcal = 0;
          tfat = 0;
          tgram = 0;
          tprot = 0;
          for (var item in querySnapshot.docs) {
            tcab = tcab + item['carbon'] as int;
            tcal = tcal + item['calories'] as int;
            tfat = tfat + item['fats'] as int;
            tprot = tprot + item['protiens'] as int;
            tgram = tgram + item['grams'] as int;
          }
        });
        print('Carbon Total  ' + tcab.toString());
        print('calories Total  ' + tcal.toString());
        print('fats Total  ' + tfat.toString());
        print('protiens Total  ' + tprot.toString());
        collection
            .doc(widget.gUser.email)
            .collection('food')
            .doc(widget.selectedDate.toString())
            .set({
          'tcalories': tcal,
          'tcrabs': tcab,
          'tfat': tfat,
          'tprotiens': tprot,
          'tgram': tgram
        });
      });
    } catch (e) {
      print(e);
    }
  }
}
