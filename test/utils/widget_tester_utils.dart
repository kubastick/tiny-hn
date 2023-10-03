import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterUtils on WidgetTester {
  Future<void> pumpAppWidget(Widget widget) => pumpWidget(
        MaterialApp(
          home: widget,
          debugShowCheckedModeBanner: false,
        ),
      );
}
