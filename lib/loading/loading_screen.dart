import 'package:flutter/material.dart';

// location_screen.dart 파일 불러오기
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weatherapp/services/weather.dart';

import '../screens/location_screen.dart';

// 로딩 화면에 대한 클래스를 작성한다.
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // 초기값으로 getLocationData메소드를 실행시킨다.
    // 즉, 특정 위치에서의 날씨 데이터를 실행시키는 소리다.
    // 해당 메서드는 아래에서 정의한다.
    getLocationData();
  }

  void getLocationData() async {
    // getLocationData라는 함수는 특정 위치의 날씨 데이터를 반환해 준다.
    var weatherData = await WeatherModel().getLocationWeather();
    // 특정 위치에 대한 날씨 데이터를 비동기식으로 받아와서 weatherData 변수에 할당한다.
    Navigator.push(// 이 메소드를 통해 화면 전환을 할 수 있다.
      context,
      MaterialPageRoute( // 여기에 전환할 페이지를 return 값에 넣어준다.
        builder: (context) {
          return LocationScreen(locationWeather: weatherData);
          // LocationScreen 이라고 날씨 데이터를 표시해주는 클래스 이며,
          // 이 클래스를 인자로 locationWeather를 받아서 해당 날씨 데이터값을 값으로 갖는다.
        },
      ),
    );
  }


  // 초기값으로 getLocationData가 불려진다. 그 다음
  // Navigator 메서드를 통해 화면 전환을 하면서 해당하는 특정 위치의 날씨데이터를 받는다.

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.black,
          size: 100
        ),
      ),
    );
  }
}
