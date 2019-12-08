import 'package:flutter_dust/models/air_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rxdart/rxdart.dart';

class AirBloc {

  // 계속 입력받다가 마지막 입력 받은 것을 뱉어낸다.
  final _airSubject = BehaviorSubject<AirResult>();

  // 생성자
  AirBloc() {
    fetch();
  }

  // fetchData 메소드가 비동기라 값을 받기 위해서는 await 해줘야됨.
  // await 해주려면 async 구현해야됨.
  // 따라서 생성자가 아닌 메소드로 따로 빼줌!!!
  void fetch() async {
    print('fetch');
    var airResult = await fetchData();
    _airSubject.add(airResult);
  }


  // AirResult 사이트에서 정보값 가져오게 하는 비동기 메소드
  Future<AirResult> fetchData() async {
    var response = await http.get(
        'https://api.airvisual.com/v2/nearest_city?key=1164b7b9-e98f-4971-8a48-94a31ada783a');
    AirResult result = AirResult.fromJson(json.decode(response.body));
    return result;
  }

  // airResult 가지고 마지막 값을 얻을 수 있음.
  Stream<AirResult> get airResult => _airSubject.stream;


}