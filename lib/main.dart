import 'package:flutter/material.dart';

import 'loading/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '오늘의 날씨',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white
          // primarySwatch에서는 MaterialColor 타입으로 선언되어 있는 색깔만 사용할 수 있다.
      ),
      home: LoadingScreen(),
    );
  }
}