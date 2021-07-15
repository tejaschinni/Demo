import 'package:caloriecounter/caloriecounter/addRecipeToDailyIntake.dart';
import 'package:caloriecounter/caloriecounter/editRecipePage.dart';
import 'package:caloriecounter/caloriecounter/viewPage.dart';
import 'package:caloriecounter/data/recipies.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ListViewSearchBar extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  List<Recipies> userRecipeList;
  DateTime selectedDate;
  ListViewSearchBar(
      this.gUser, this.signOut, this.userRecipeList, this.selectedDate);
  @override
  _ListViewSearchBarState createState() => _ListViewSearchBarState();
}

class _ListViewSearchBarState extends State<ListViewSearchBar> {
  List<Recipies> _foundRecipe = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _foundRecipe = widget.userRecipeList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(

      //   actions: [
      //     Center(
      //       child: Container(
      //           child: InkWell(
      //         child: Icon(Icons.arrow_back),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       )),
      //     )
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundRecipe.length > 0
                  ? ListView.builder(
                      itemCount: _foundRecipe.length,
                      itemBuilder: (context, index) => InkWell(
                        child: ListTile(
                          title: Text(
                            _foundRecipe[index].name.toString(),
                          ),
                          subtitle: Text(_foundRecipe[index].grams.toString()),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contex) => AddRecipeToDailyIntake(
                                        widget.gUser,
                                        widget.signOut,
                                        widget.selectedDate,
                                        _foundRecipe[index].reference.id,
                                        _foundRecipe[index],
                                      )));
                          print("On clicked on a particular recipe");
                          print('--------------------' +
                              _foundRecipe[index].name.toString());
                        },
                      ),
                    )
                  : Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<Recipies> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = widget.userRecipeList;
    } else {
      results = widget.userRecipeList
          .where((user) =>
              user.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundRecipe = results;
    });
  }
}
