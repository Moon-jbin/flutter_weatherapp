import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(fontFamily: 'FredokaOne', fontSize: 100.0);

const kMessageTextStyle = TextStyle(fontFamily: 'FredokaOne', fontSize: 30.0);

const kButtonTextStyle = TextStyle(fontSize: 30.0, fontFamily: 'FredokaOne');

const kConditionTextStyle = TextStyle(fontSize: 100.0);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: '도시를 입력해주세요.',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
    borderSide: BorderSide.none
  ),
);
