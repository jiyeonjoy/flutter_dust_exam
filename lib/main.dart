import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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
      body: Center(
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
                    color: Colors.yellow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('얼굴사진'),
                        Text(
                          '80',
                          style: TextStyle(fontSize: 40),
                        ),
                        Text('보통', style: TextStyle(fontSize: 20))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('이미지'),
                            SizedBox(
                              width: 16,
                            ),
                            Text('11º', style: TextStyle(fontSize: 16))
                          ],
                        ),
                        Text('습도 100%'),
                        Text('풍속 5.7m/s')
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
              child: RaisedButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
                color: Colors.orange,
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
