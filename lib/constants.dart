import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.grey),
  hintText: 'Enter a value ',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.yellowAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.yellowAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
Function validator = (String value) {
  if (value.isEmpty) {
    return "Filed Can not be empty";
  }
  return null;
};

Function descriptionValidator = (String value) {
  if (value.isEmpty) {
    return "Filed Can not be empty";
  } else if (value.length < 10) {
    return 'Description must be at least 10 characters';
  }
  return null;
};

Function priceValidator = (String value) {
  RegExp regExp = RegExp('[0-9.]+');
  if (value.isEmpty) {
    return "Filed Can not be empty";
  } else if (!regExp.hasMatch(value)) {
    return 'Price must only contains numbers';
  }
  return null;
};

Function imageValidator = (String value) {
  if (value.isEmpty) {
    return "Filed Can not be empty";
  } else if (!value.startsWith('http') && !value.startsWith('https')) {
    return 'Please enter a valid URL';
  }
  return null;
};
