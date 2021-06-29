import 'package:caloriecounter/caloriecounter/addDailyIntakePage.dart';
import 'package:caloriecounter/caloriecounter/nutritionPerDay.dart';
import 'package:caloriecounter/demo/flutterTimedatePicker.dart';
import 'package:caloriecounter/logouPage.dart';
import 'package:caloriecounter/signInPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ViewPage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  ViewPage(this.gUser, this.signOut);

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('caloriecounter').snapshots();

  DateTime _selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  bool flag = false;
  Timestamp startTimestamp = Timestamp.now();
  DateTime startDateTime = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    // print('Date ' + startDateTime.toString());
    _read();
  }

  void _read() async {
    //print(' My email  = ' + widget.gUser.email.toString());
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await firestore
          .collection('caloriecounter')
          .doc(widget.gUser.email)
          .get();
      setState(() {
        startTimestamp = (documentSnapshot.data() as dynamic)['date'];
        startDateTime = DateTime.fromMicrosecondsSinceEpoch(
            startTimestamp.microsecondsSinceEpoch);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddDailyIntakePage(
                        widget.gUser, _selectedDate, widget.signOut)));
          },
        ),
        appBar: AppBar(
          title: Text('View Data'),
          actions: [
            Center(
              child: Container(
                padding: EdgeInsets.all(5),
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
                  .collection('food')
                  .doc(_selectedDate.toString())
                  .collection('meals')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var food;

                try {
                  food = snapshot.data!.docs;

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
                          child: Container(
                        padding: EdgeInsets.all(10),
                        child: NutritionPerDay(widget.gUser, _selectedDate),
                      )),
                      Expanded(
                          child: Container(
                              child: FlutterDateTimeDemo(
                                  startDateTime, setDateTime))),
                      Expanded(
                          flex: 4,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: food.length == 0
                                ? Container(
                                    child: Center(child: Text('NO DATA Found')))
                                : ListView.builder(
                                    itemCount: food.length,
                                    itemBuilder: (context, index) {
                                      return Container(
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
                                                        text: food[index]
                                                                ['name']
                                                            .toString(),
                                                        style:
                                                            DefaultTextStyle.of(
                                                                    context)
                                                                .style,
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text: '\n ' +
                                                                  food[index][
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
                                                    text: food[index]
                                                            ['calories']
                                                        .toString(),
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: '\nC: ' +
                                                              food[index]
                                                                      ['carbon']
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey)),
                                                      TextSpan(
                                                          text: '\t F: ' +
                                                              food[index]
                                                                      ['fats']
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .orange)),
                                                      TextSpan(
                                                          text: '\t P: ' +
                                                              food[index][
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
                                      );
                                    }),
                          )),
                    ],
                  );
                }
              },
            )));
  }

  void setDateTime(DateTime _selectedValue) {
    setState(() {
      this._selectedDate = _selectedValue;
    });

    print('--------sss-----------' + _selectedDate.toString());
  }
}
