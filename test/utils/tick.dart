import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> tick(WidgetTester tester, [int s = 0]) async {
  await tester.pump();
  await tester.pump(Duration(seconds: s));
  await tester.pump();
}

Future<void> tap(WidgetTester tester, Finder finder, [int s = 0]) async {
  await tester.ensureVisible(finder);
  await tester.pump(Duration(seconds: s));
  await tester.tap(finder);
  await tick(tester, s);
}

Future<void> tapByKey(WidgetTester tester, Key key, [int s = 0]) async {
  await tap(tester, find.byKey(key), s);
}

Future<void> tapByStringKey(
  WidgetTester tester,
  String key, [
  int s = 0,
]) async {
  await tap(tester, find.byKey(Key(key)), s);
}

Future<void> tapByText(WidgetTester tester, String text, [int s = 0]) async {
  await tap(tester, find.text(text), s);
}

Future<void> enterText(WidgetTester tester, Finder finder, String value,
    [int s = 0]) async {
  await tester.enterText(finder, value);
  await tick(tester, s);
}

Future<void> tapBackBtn(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.arrow_back));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await tick(tester, 2);
}

bool isIconBtnEnabled(WidgetTester tester, Finder finder) {
  return tester.widget<GestureDetector>(finder).onTap != null;
}

String? textContent(WidgetTester tester, Finder finder) {
  return tester.widget<Text>(finder).data;
}

LinearProgressIndicator findLPIndicator(WidgetTester tester, String strKey) {
  return tester.widget(find.byKey(Key(strKey)));
}

Text findTextWidget(WidgetTester tester, String strKey) {
  return tester.widget<Text>(find.byKey(Key(strKey)));
}

Future<void> tapBackButton(WidgetTester tester, [int s = 0]) async {
  await tester.tap(find.byTooltip('Back').last);
  await tester.pump(Duration(seconds: s));
}
