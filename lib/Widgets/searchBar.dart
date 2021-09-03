import 'package:flutter/material.dart';
import '../models/user.dart';

class SearchBar extends StatelessWidget {
  Function onSearch;

  SearchBar(this.onSearch);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: TextField(
        cursorHeight: 20,
        onChanged: (value) => onSearch(value),
        cursorColor: Colors.pinkAccent,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[850],
          contentPadding: EdgeInsets.all(20),
          suffixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none),
          hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
          hintText: "Search users",
        ),
      ),
    );
  }
}
