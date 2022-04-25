import 'package:flutter/material.dart';
import 'package:weatherapp/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

// 해당 클래스 는 cityName 이란 state 값을 갖는다.
class _CityScreenState extends State<CityScreen> {
  late String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue,
        constraints: const BoxConstraints.expand(),
        // expand()에 인자가 없을 경우에는 부모위젯을 꽉 채우게 된다.
        child: SafeArea(
          // 레이아웃이 짤리지 않게 방지해준다.
          child: Column(
            children: [
              Align(
                // 위에서 왼쪽 방향에다가 icon을 생성한다.
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    // 해당 icon을 클릭시 뒤로가게 된다.
                    // 인자로 넘겨주는 값이 없기 때문에 typedName에서 받는 결과로는 null로 인지한다.
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  decoration: kTextFieldInputDecoration,
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, cityName);
                  // 이 버튼을 클릭시 뒤로가질때 cityName값이 location_screen에 typedName 값에 할당된다.
                  // 즉, 내가 검색한 state의 값이 location_screen 으로 넘어가져서 활용이 되는
                  // 이른바 상태관리가 된다.
                },
                child: const Text(
                  '날씨를 불러옵니다.',
                  style: kButtonTextStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
