import 'package:flutter/material.dart';
import 'package:fv1/models/chapter.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:fv1/providers/browser_state.dart';
import 'package:fv1/ui/routes.dart';
import 'package:fv1/ui/widgets/app_card.dart';
import 'package:fv1/ui/widgets/app_container.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:fv1/ui/widgets/h1.dart';
import 'package:fv1/ui/widgets/loader.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TeachingSummaryScreen extends StatelessWidget {
  static const teachingIdKey = 'teachingId';
  static const backButtonKey = Key('TSBackButton');

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
    _onOpenChapter(widget._state.activeProgress!.getNextChapterIndex());
  }

  void _onOpenChapter(int chapterIndex) {
    final params =
        Map<String, String>.from(GoRouterState.of(context).pathParameters);
    params['chapterIndex'] = chapterIndex.toString();
    GoRouter.of(context).goNamed(Routes.chapter, pathParameters: params);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final teachingId = readTeachingId(context);
    if (teachingId != _prevId) {
      _prevId = teachingId;
      widget._state.loadLocalTeaching(readTeachingId(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget._state.activeProgress;
    final teaching = progress?.teaching;
    return AppContainer(
      backButton: true,
      backButtonKey: TeachingSummaryScreen.backButtonKey,
      key: const Key(Routes.teachingSummary),
      body: WrapInLoader(
        isReady: teaching != null,
        builder: () => AppCard(
          padding: 12,
          child: Column(
            children: [
              ScreenH1(teaching!.title, textKey: const Key('TSTitle')),
              Text(teaching.subtitle, key: const Key('TSSubtitle')),
              Expanded(
                child: ListView(
                  children: [
                    for (int i = 0; i < teaching.chapters.length; i++)
                      _ChapterCard(
                        teaching.chapters[i],
                        i,
                        progress!.isChapterDone(i),
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
      ),
    );
  }
}

class _ChapterCard extends StatelessWidget {
  final int _index;
  final ChapterModel _chapter;
  final bool _isDone;
  final void Function() _onTap;

  const _ChapterCard(this._chapter, this._index, this._isDone, this._onTap);

  @override
  Widget build(BuildContext context) {
    final primColor = Theme.of(context).primaryColor;
    return ListTile(
      title: Text(_chapter.title),
      trailing: _isDone
          ? Icon(
              key: Key('DoneIcon$_index'),
              Icons.check,
              color: Colors.black45,
            )
          : Icon(Icons.chevron_right, color: primColor),
      onTap: _onTap,
    );
  }
}
