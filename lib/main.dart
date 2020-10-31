import 'package:flutter/material.dart';
import 'package:flutter_dust/bloc/air_bloc.dart';
import 'package:flutter_dust/models/air_result.dart';


void main() => runApp(MyApp());

// 최상위에 두면 아무데서나 갖다 쓸 수 있기 때문에 여기에 둠.
final airBloc = AirBloc();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 비동기로 미세먼지 정보를 받아오다 보니 build가 먼저 실행되면 에러뜸
      // 따라서 아직 _result 값이 널이면 프로그래스바가 돌면서 기다리게 설정해줌!!!
      body: Center(
        child: StreamBuilder<Object>(
          stream: airBloc.airResult,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return buildBody(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }
          }
        )
      ),
    );
  }

  Widget buildBody(AirResult _result) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '현재 위치 미세먼지',
              style: TextStyle(fontSize: 30),
            ),
            // 공간 생성하는 것임. 패딩과 같은 것 임
            SizedBox(
              height: 16,
            ),
            Card(
              child: Column(
                children: <Widget>[
                  // Row 에는 배경색 지정 못해서 Container로 감싼것임
                  // Container 는 왠만하면 모든 속성 다 있음
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: _getColor(_result),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('얼굴사진'),
                        Text(
                          '${_result.data.current.pollution.aqicn}',
                          style: TextStyle(fontSize: 40),
                        ),
                        Text(_getString(_result),
                            style: TextStyle(fontSize: 20))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.network(
                              'https://airvisual.com/images/03d.png',
                              width: 32,
                              height: 32,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                                '${_result.data.current.weather.tp}º',
                                style: TextStyle(fontSize: 16))
                          ],
                        ),
                        Text(
                            '습도 ${_result.data.current.weather.hu}%'),
                        Text(
                            '풍속 ${_result.data.current.weather.ws}m/s')
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            // 모서리 둥글레 해주는 위젯
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 50),
                color: Colors.orange,
                child: InkWell(
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  onTap: () {
                    airBloc.fetch();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color _getColor(AirResult result) {
    if (result.data.current.pollution.aqicn <= 50) {
      return Colors.greenAccent;
    } else if (result.data.current.pollution.aqicn <= 100) {
      return Colors.yellow;
    } else if (result.data.current.pollution.aqicn <= 150) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String _getString(AirResult result) {
    if (result.data.current.pollution.aqicn <= 50) {
      return '좋음';
    } else if (result.data.current.pollution.aqicn <= 100) {
      return '보통';
    } else if (result.data.current.pollution.aqicn <= 150) {
      return '나쁨';
    } else {
      return '최악';
    }
  }
}
