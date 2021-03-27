import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'user_category.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Categories with ChangeNotifier {
  List<UserCategory> _categories = [
    UserCategory(
        titel: 'Clothes',
        imageUrl:
            'https://i0.wp.com/post.healthline.com/wp-content/uploads/2020/07/Best_Baby_Clothes_1296x728.png?w=1155&h=1528'),
    UserCategory(
        titel: 'Clothes',
        imageUrl:
            'https://i0.wp.com/post.healthline.com/wp-content/uploads/2020/07/Best_Baby_Clothes_1296x728.png?w=1155&h=1528'),
    UserCategory(
        titel: 'Clothes',
        imageUrl:
            'https://i0.wp.com/post.healthline.com/wp-content/uploads/2020/07/Best_Baby_Clothes_1296x728.png?w=1155&h=1528'),
    UserCategory(
        titel: 'Clothes',
        imageUrl:
            'https://i0.wp.com/post.healthline.com/wp-content/uploads/2020/07/Best_Baby_Clothes_1296x728.png?w=1155&h=1528'),
    UserCategory(
        titel: 'Clothes',
        imageUrl:
            'https://i0.wp.com/post.healthline.com/wp-content/uploads/2020/07/Best_Baby_Clothes_1296x728.png?w=1155&h=1528'),
    UserCategory(
        titel: 'Clothes',
        imageUrl:
            'https://i0.wp.com/post.healthline.com/wp-content/uploads/2020/07/Best_Baby_Clothes_1296x728.png?w=1155&h=1528'),
    UserCategory(
        titel: 'Clothes',
        imageUrl:
            'https://i0.wp.com/post.healthline.com/wp-content/uploads/2020/07/Best_Baby_Clothes_1296x728.png?w=1155&h=1528'),
    UserCategory(
        titel: 'Clothes',
        imageUrl:
            'https://i0.wp.com/post.healthline.com/wp-content/uploads/2020/07/Best_Baby_Clothes_1296x728.png?w=1155&h=1528'),
    UserCategory(
        titel: 'Clothes',
        imageUrl:
            'https://i0.wp.com/post.healthline.com/wp-content/uploads/2020/07/Best_Baby_Clothes_1296x728.png?w=1155&h=1528'),
    UserCategory(
        titel: 'Clothes',
        imageUrl:
            'https://i0.wp.com/post.healthline.com/wp-content/uploads/2020/07/Best_Baby_Clothes_1296x728.png?w=1155&h=1528'),
  ];

  List<UserCategory> get categories {
    return [..._categories];
  }
}
