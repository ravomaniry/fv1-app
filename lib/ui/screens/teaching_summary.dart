import 'package:flutter/material.dart';
import 'package:fv1/models/chapter.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:fv1/providers/browser_state.dart';
import 'package:fv1/ui/router_utils.dart';
import 'package:fv1/ui/screens/chapter.dart';
import 'package:fv1/ui/widgets/app_container.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:fv1/ui/widgets/h1.dart';
import 'package:fv1/ui/widgets/loader.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TeachingSummaryScreen extends StatelessWidget {
  static const route = '/teaching';
  static const teachingIdKey = 'teachingId';

  const TeachingSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppState, BrowserState>(
        builder: (_, appState, state, __) => _ScreenBody(appState, state));
  }
}

class _ScreenBody extends StatefulWidget {
  final AppState _appState;
  final BrowserState _state;

  const _ScreenBody(this._appState, this._state);

  @override
  State<_ScreenBody> createState() => _ScreenBodyState();
}

class _ScreenBodyState extends State<_ScreenBody> {
  int? _prevId;

  void _onContinue() {
    _onOpenChapter(0);
  }

  void _onOpenChapter(int chapterIndex) {
    final params =
        Map<String, String>.from(GoRouterState.of(context).pathParameters);
    params['chapterIndex'] = chapterIndex.toString();
    GoRouter.of(context).goNamed(ChapterScreen.route, pathParameters: params);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final teachingId = readTeachingId(context);
    if (teachingId != _prevId) {
      _prevId = teachingId;
      widget._state.loadTeaching(readTeachingId(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    final teaching = widget._state.activeTeaching;
    return AppContainer(
      body: WrapInLoader(
        isReady: teaching != null,
        builder: () => Column(
          children: [
            ScreenH1(teaching!.title),
            Expanded(
              child: ListView(
                children: [
                  for (int i = 0; i < teaching.chapters.length; i++)
                    _ChapterCard(
                      teaching.chapters[i],
                      () => _onOpenChapter(i),
                    ),
                ],
              ),
            ),
            ContinueButton(
              label: widget._appState.texts.continueButton,
              onPressed: _onContinue,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChapterCard extends StatelessWidget {
  final ChapterModel _chapter;
  final void Function() _onTap;

  const _ChapterCard(this._chapter, this._onTap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_chapter.title),
      onTap: _onTap,
    );
  }
}
