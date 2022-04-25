import 'package:weatherapp/services/location.dart';
import 'package:weatherapp/services/networking.dart';

// 이 클래스에서 받아온 날씨 데이터를 반환하는 메서드를 작성할 것이다.
const apiKey = 'de7443ed3b2903330e529304093cb041';
// 회원가입을 통해 얻은 apiKey 값
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
// 반복해서 사용될 거라 고정된 내용만 가지고 와서 변수에담아 사용할것이다.


// 이 클래스를 2가지의 주요 날씨데이터를 반환해준다.
// 1. 도시명을 검색함에 따라 반환하는 날씨 데이터
// 2. 좌표에 따라 반환하는 날씨 데이터 이다.

// 도시명일떄는 위도,경도가 필요 없지만, 좌표에 따라서는 위도, 경도가 필요하다.

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    // 도시명에 따라 날씨 데이터를 반환하는 메서드이다.
    // API의 값을 받아서 반환 하는 과정이기에 Future 비동기 를 사용하고, async, await를 사용한다.
    var url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    // 쿼리 값에 q는 도시명, appid는 apikey값, unites는 metric으로 설정한다.
    NetworkHelper networkHelper = NetworkHelper(url);
    // 날씨 데이터를 받는 클래스를 변수에 담아서 인자로 받아온 api 값을 인자로 넣어준다.
    var weatherData = await networkHelper.getData();
    // 그리곤 networkHelper 변수를 사용해 getData(); 즉, 날씨 데이터를 구한값을 받아오고
    // 마지막으로 반환한다.
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    // 특정 좌표에 따라 날씨 데이터를 반환하는 메서드이다.
    Location location = Location(); // 위도, 경도를 갖고 있는 클래스를 location 변수에 담아준다.
    await location.getCurrentLocation();
    // 비동기 식으로다가 현재 좌표인 값을 받아온다.

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    // 위도와 경도가 직접 들어간 url을 인자로 던져주고, 구한 날씨 데이터 값을
    // 변수 weatherData로 비동기로 값을 할당한다.

    return weatherData;
  }



  // 날씨를 반환해 주는 클래스에서 해당 컨디션일때마다 어떤 아이콘이 나오면 좋을지,
  // 또는 어떤 온도에서는 어떤 문구가 나오면 좋을지 적어주는 메서드를 작성해 주는게 좋다.
  // 어떤 데이터를 내보내는 역할을 하는 곳이기 때문에 같은 속성이라고 생각하기 때문이다.


  String getWeatherIcon(int condition){
    // 해당 날씨의 컨디션에 따라 어떤 아이콘을 반환할지 조정해주는 메서드이다.
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌩';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return '오늘은 맥주파티다.';
    } else if (temp > 20) {
      return '쫌 덥다.. 반팔입는게 좋을듯..?';
    } else if (temp < 10) {
      return '오늘 쌀쌀해..겉옷 챙기고 긴팔입자';
    } else {
      return '날씨가 좋으니까 입고 싶은거 입자.';
    }
  }


}





















