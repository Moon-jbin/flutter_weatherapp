import 'package:http/http.dart' as http;
import 'dart:convert';
// 이 클래스를 날씨 데이터를 Get 하는 클래스이다.
// 따라서 반환해주는 클래스(WeatherModel)를 따로 또 작성 해야 한다.

// 해당 NetworkHelper 클래스는 인자로 url을 받는다.
// 이 url에는 openweather API가 들어올 것이다.
class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future getData() async {
    // 비동기로 날씨에 대한 날씨 데이터를 이 함수로 받는다.
    http.Response response = await http.get( // http.Response라는 자료형을 타입으로 갖으며
      // response 라는 변수에 날씨 데이터를 할당한다.
      Uri.parse(url),  // << 이 url는 openweather API를 담고 있을 것이다.
      // 그래서 그 API를 URI로 parse후 정보를 가지고 오는 것이다.
    );
    if(response.statusCode == 200) {
      // 만약 서버가 OK 응답을 반환하면 다음 구현문을 작동한다.
      String data = response.body; // 응답한 변수의 body값을 data에 할당한 후
      // response.body는 날씨가 저장된 부분이다.
      return jsonDecode(data); // 그 data인 JSON을 파싱한다.
      // jsonDecode는 특정 날씨정보만 사용할 수 있도록 파싱이 가능하게 해준다.
    } else {
      print(response.statusCode);
      // 서버가 OK응답이 아닐경우 어떤 종류의 오류인지 확인하기 위해
      //console 에 statusCode를 출력한다.
    }
  }
}
