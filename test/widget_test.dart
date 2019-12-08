// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_dust/models/air_result.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_dust/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// 데이터를 잘 가져오는지 확인하는 테스트 코드.
// 옆에 초록색 삼각형 클릭하면 확인 가능!!
void main() {
  test('http 통신 테스트', () async {
    var response = await http.get('https://api.airvisual.com/v2/nearest_city?key=1164b7b9-e98f-4971-8a48-94a31ada783a');

    expect(response.statusCode, 200);

    AirResult result = AirResult.fromJson(json.decode(response.body));
    expect(result.status, 'success');
  });
}
