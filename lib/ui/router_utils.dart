import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

const teachingIdKey = 'teachingId';
const chapterIndexKey = 'chapterIndex';

int readTeachingId(BuildContext context) {
  return int.parse(GoRouterState.of(context).pathParameters[teachingIdKey]!);
}

int readChapterIndex(BuildContext context) {
  return int.parse(GoRouterState.of(context).pathParameters[chapterIndexKey]!);
}
