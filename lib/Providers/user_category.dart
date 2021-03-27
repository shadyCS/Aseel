import 'package:flutter/material.dart';

class UserCategory with ChangeNotifier {
  UserCategory({this.titel, this.imageUrl});
  final String titel;
  final String imageUrl;
}
