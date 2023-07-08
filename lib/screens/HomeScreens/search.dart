import 'package:flutter/material.dart';


class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Search",

          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 50,
          ),),
      ),
    );
  }
}
