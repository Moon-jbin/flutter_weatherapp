import 'package:flutter/material.dart';
import 'package:weatherapp/services/weather.dart';
import 'package:weatherapp/utilities/constants.dart';
import 'city_screen.dart';

// 위치에 따른 날씨데이터를 화면에 "출력" 하는 클래스이다.
class LocationScreen extends StatefulWidget {
  // 이 클래스는 인자값으로 locationWeather 값을 받는다.
  final locationWeather;

  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel(); // 날씨 데이터를 반환하는 클래스를 가져와서
  // weather 변수에 할당한다.

  // WeatherModel 클래스에서 작업한 내용을 변수에 담을 예정이기 때문에
  // 해당 변수 이름들을 작성 후 선언해주자.
  late int temperature; //온도
  late String cityName; // 도시명
  late String wearchIcon; // 날씨 아이콘
  late String weatherMessage; // 날씨에 대한 메세지

  @override
  void initState() {
    super.initState();
    // location_screen 즉, 특정 위치에서의 초기값 화면을 updateUI 메서드로 잡아준다.
    // 해당 메서드는 바로 밑에서 작업할 것이다.
    updateUI(widget.locationWeather);
  }

  void updateUI(var weatherData) {
    // updateUI는 인자로 weatherData를 받는다.
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        wearchIcon = 'Error';
        weatherMessage = '날씨 데이터를 가져올 수 없습니다.';
        cityName = '지금';
        return;
      }
      double temp = weatherData['main']['temp'];
      // 아마도 weatherData는 2중 배열을 가질 것이다 즉,
      // 특정 위치에 대한 날씨 데이터를 비동기식으로 받아온 데이터가 2중 배열이라는 소리다.
      // 모르겠다면 코드를 타고 올라가 보면 된다.
      temperature =
          temp.toInt(); // 2중 배열에 있는 온도 값을 toInt()로 인해 정수로 잘라서 int로 반환한다.
      int condition = weatherData['weather'][0]['id'];
      weatherMessage = weather.getMessage(temperature);
      wearchIcon = weather.getWeatherIcon(condition);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar에서가 아닌 body에서 위에서 아래로 레이아웃을 잡는다.
      body: Container(
        color: Colors.lightBlue,
        constraints: const BoxConstraints.expand(),
        // BoxConstraints는 4가지의 속성을 자식에게 상속시켜준다.
        // expand()라고 한다면 인자를 넣지 않으면 부모 위젯 크기를 다 채워 버린다.
        child: SafeArea(
          // 사전에 레이아웃이 짤림을 방지하기 위해 선언한다.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      // 종이비행기 같은 아이콘을 클릭시
                      // 비동기 방식으로 특정 위치에 있는 날씨 데이터를 weatherData에 받는다.
                      var weatherData = await weather.getLocationWeather();
                      // print(weatherData);
                      // 그리고는 updateUI() 메서드를 활성화 시키는데 인자로 weatherData를 넣어준다.
                      updateUI(weatherData);
                    },
                    icon: const Icon(Icons.near_me,
                        size: 50.0, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: ()  async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return CityScreen();
                        }),
                      ); // 해당 아이콘을 클릭시 도시별 날씨 데이터를 볼 수 있게 page 전환되게 하는데
                      // 전환되어 CityScreen() 화면이 보여지는 데이터를 typedName 변수에 할당한다.

                      // 현재 까지의 상황 파익으로는 typedName 값은 내가 검색한 도시명이 출력된다.
                      // 그런게 왜 다른 버튼이 클릭시 print 가 되는것일까?
                      print(typedName);
                      // 개인적인 소견으로는 이렇다.
                      // 해당 typedName 은 현재 비동기이다.
                      // 데이터를 받아올때 까지 계속해서 실행되고 있는 중인것이다.
                      // 따라서 이전으로 돌아가는 버튼때 print 출력이라는 말 보다는
                      // cityScreen 에서의 데이터값을 null 이든, 값이 있던 데이터를 받았을 때,
                      //동작은 한다고 생각한다. // 그래서 결국 검색된 결과값을 얻어서
                      // location screen 으로 왔을때 해당 검색어를 인자로 넣어서 weather 데이터를 변경시킨다.

                      //어찌 보면 비동기를 활용해서 나타낸 기술이라고 볼 수 있을 것 같다.

                      // 그래서 내가 적은 도시명을 여기서 인자로 던진것을 받아서 typedName에다가 넣은 것이다.
                      // https://devmemory.tistory.com/40 해당 블로그에 내용을 확인한 결과
                      // 내가 조사한 것이 맞았다.
                      // Navigator에서 async, await를 하게 되면 pop 될때까지 기다렸다가
                      // 인자로 result값이 넘어오면 typedName에 해당 인자값을 할당시킨다.
                      // 이는 provider나 Bloc을 사용한 상태관리를 대신한 상태관리라고 한다.

                      if (typedName != null) {
                        //만약 typedName 의 값이 null 이 아닐 경우 즉, 값을 가질 때
                        // weatherData 에다가 도시별 날짜 데이터를 반환하는 메서드에 typedName 값을 인자로 던져서 데이터를 받고,
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(
                            weatherData); // 그리곤 해당 도시별 인자에 대한 데이터 값을 인자로 던져준다.
                      }
                    },
                    icon: const Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text(
                      '$temperatureº',
                      style: kTempTextStyle,
                    ),
                    Text(
                      wearchIcon,
                      style: kConditionTextStyle,
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '$cityName은 $weatherMessage',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
