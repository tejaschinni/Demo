import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AddRecipePage extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  DateTime selectedDate;

  AddRecipePage(this.gUser, this.selectedDate, this.signOut);

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController gramsController = TextEditingController();
  TextEditingController carbonController = TextEditingController();
  TextEditingController fatsController = TextEditingController();
  TextEditingController protiensController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();

  String name = ' ';
  int grams = 0, carbon = 0, fats = 0, protiens = 0, calories = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: SafeArea(
        child: Center(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
