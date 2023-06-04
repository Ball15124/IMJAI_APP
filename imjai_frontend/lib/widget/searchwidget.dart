import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search for your interest',
          prefixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
