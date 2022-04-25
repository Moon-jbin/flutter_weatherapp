import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// 해당 Location 클래스는 인자도 위도, 경도를 갖는다.
class Location {
  double? latitude; // 위도
  double? longitude; // 경도
  // late 또한 내가 궁금해 하던 null-safety에서 나온 녀석이다.
  // late는 초기화 시점을 뒤로 미루겠다는 의미이다.
  // 말 그대로 선언을 일단 해두고 초기값을 나중에 설정을 해줘야 사용이 가능하다.

  Future<void> getCurrentLocation() async {
    try {
      // 예외 처리를 위해서 try, catch 문을 사용한다.
      LocationPermission permission = await Geolocator.checkPermission();
      // LocationPermission 이란 자료형을 가진 변수를 담는다. 즉,
      // 위치 권한을 담을 변수이다. 그래서 패키지로 받아온 Geolocatior 에서 확인한 권한값을 할당한다.
      if (permission == LocationPermission.denied) {
        //denied는 거부됨 이란 뜻이다.
        // 즉, Geolocator에서 받아온 권한값이 거부됨이란 값과 동일하다면  다음 구현문을 작동시킨다.
        permission = await Geolocator.requestPermission();
        // 권한을 받는 변수에 권한을 다시 요청한다.
      }
      Position position = await Geolocator.getCurrentPosition(
          //여기부턴 if문과 상관 없이 position 이란 변수에 Geolocatior에서 현재 위치를 받아준다.
          // Geolocator API로 위도와 경도를 불러오기 위해서 이 메서드를 사용한다.
          desiredAccuracy: LocationAccuracy.low); // low, high를 통해 정확도 설정이 가능하다.
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
