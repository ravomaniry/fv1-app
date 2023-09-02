import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> tick(WidgetTester tester, [int s = 0]) async {
  await tester.pump();
  await tester.pump(Duration(seconds: s));
  await tester.pump();
}

Future<void> tap(WidgetTester tester, Finder finder, [int s = 0]) async {
  await tester.tap(finder);
  await tick(tester, s);
}

Future<void> tapByKey(WidgetTester tester, String key) async {
  await tester.tap(find.byKey(Key(key)));
  await tick(tester);
}

Future<void> tapByText(WidgetTester tester, String text, [int s = 0]) async {
  await tester.tap(find.text(text));
  await tick(tester, s);
}

Future<void> enterText(WidgetTester tester, Finder finder, String value,
    [int s = 0]) async {
  await tester.enterText(finder, value);
  await tick(tester, s);
}

Future<void> tapBackBtn(WidgetTester tester) async {
  await tapByKey(tester, 'back_btn');
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await tick(tester, 2);
}

bool isIconBtnEnabled(WidgetTester tester, Finder finder) {
  return tester.widget<GestureDetector>(finder).onTap != null;
}

String? textContent(WidgetTester tester, Finder finder) {
  return tester.widget<Text>(finder).data;
}
