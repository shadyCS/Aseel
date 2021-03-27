import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'user_category.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Categories with ChangeNotifier {
  List<UserCategory> _categories = [];
  List<DropdownMenuItem> _dropdownList = [];

  List<UserCategory> get categories {
    return [..._categories];
  }

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://myshopapp-cd82e-default-rtdb.firebaseio.com/categories.json';
    try {
      List<UserCategory> loadedCategories = [];
      List<DropdownMenuItem> drop = [];
      var response = await get(Uri.parse(url));
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data == null) {
        return;
      }
      data.forEach((categoryId, categoryData) {
        loadedCategories.add(UserCategory(
            titel: categoryData['title'], imageUrl: categoryData['imageUrl']));
        drop.add(DropdownMenuItem(
          child: Text(categoryData['title']),
          value: categoryData['title'],
        ));
        print(drop[0].value);
      });
      _categories = loadedCategories;
      _dropdownList = drop;
      notifyListeners();
    } catch (ex) {}
  }

  List<DropdownMenuItem> get dropdownList {
    print(_dropdownList[0].value);
    return [..._dropdownList];
  }
}
