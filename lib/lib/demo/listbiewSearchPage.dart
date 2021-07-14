import 'package:caloriecounter/caloriecounter/viewPage.dart';
import 'package:caloriecounter/data/recipies.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ListViewSearchBar extends StatefulWidget {
  Function signOut;
  GoogleSignInAccount gUser;
  List<Recipies> userRecipeList;
  ListViewSearchBar(this.gUser, this.signOut, this.userRecipeList);
  @override
  _ListViewSearchBarState createState() => _ListViewSearchBarState();
}

class _ListViewSearchBarState extends State<ListViewSearchBar> {
  List<Recipies> _foundRecipe = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Bar'),
        actions: [
          Center(
            child: Container(
                child: InkWell(
              child: Icon(Icons.arrow_back),
              onTap: () {
                Navigator.pop(context);
              },
            )),
          )
        ],
      ),
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
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundRecipe[index].name),
                        color: Colors.amberAccent,
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          // leading: Text(
                          //   _foundRecipe[index].name.toString(),
                          //   style: TextStyle(fontSize: 24),
                          // ),
                          title: Text(_foundRecipe[index].name.toString()),
                          subtitle:
                              Text('${_foundRecipe[index].grams.toString()} '),
                        ),
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
