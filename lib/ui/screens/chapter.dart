import 'package:flutter/material.dart';
import 'package:fv1/models/section.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:fv1/providers/browser_state.dart';
import 'package:fv1/ui/router_utils.dart';
import 'package:fv1/ui/screens/quiz.dart';
import 'package:fv1/ui/widgets/app_container.dart';
import 'package:fv1/ui/widgets/card_container.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:fv1/ui/widgets/icon_button.dart';
import 'package:fv1/ui/widgets/loader.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../widgets/h1.dart';

class ChapterScreen extends StatelessWidget {
  static const route = '/chapter';
  static const backButtonKey = Key('ChapterBackButton');

  const ChapterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppState, BrowserState>(
      builder: (_, appState, state, __) => _ChapterScreenBody(appState, state),
    );
  }
}

class _ChapterScreenBody extends StatelessWidget {
  final AppState _appState;
  final BrowserState _state;

  const _ChapterScreenBody(this._appState, this._state);

  void _onContinue(BuildContext context) {
    GoRouter.of(context).pushReplacementNamed(
      QuizScreen.route,
      pathParameters: GoRouterState.of(context).pathParameters,
    );
  }

  TextStyle _calcTitleStyle(BuildContext context, isPlaying) {
    final theme = Theme.of(context);
    return TextStyle(color: isPlaying ? theme.primaryColor : null);
  }

  Widget _buildSection(
    BuildContext context,
    SectionModel section,
    int chapterIndex,
    int sectionIndex,
    bool isPlaying,
  ) {
    return CardContainer(
      selected: isPlaying,
      key: Key(sectionIndex.toString()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  section.subtitle,
                  style: _calcTitleStyle(context, isPlaying),
                ),
                _buildAudioButton(
                    context, chapterIndex, sectionIndex, isPlaying),
              ],
            ),
            subtitle: Text(section.content),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioButton(
    BuildContext context,
    int chapterIndex,
    int sectionIndex,
    bool isPlaying,
  ) {
    return isPlaying
        ? Icon(
            Icons.surround_sound,
            color: Theme.of(context).colorScheme.secondary,
          )
        : AppIconButton(
            onPressed: () => _state.playAudio(chapterIndex, sectionIndex),
            icon: Icons.play_circle,
          );
  }

  @override
  Widget build(BuildContext context) {
    final chapter = _state.getActiveChapter(readChapterIndex(context));
    final teachingId = readTeachingId(context);
    final chapterIndex = readChapterIndex(context);
    final active = _state.playingAudio;
    return AppContainer(
      backButton: true,
      backButtonKey: ChapterScreen.backButtonKey,
      body: WrapInLoader(
        isReady: chapter != null,
        builder: () {
          return Column(
            children: [
              ScreenH1(
                chapter!.title,
                textKey: const Key('ChapterTitle'),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (final (sectionIndex, section)
                        in chapter.sections.indexed)
                      _buildSection(
                        context,
                        section,
                        chapterIndex,
                        sectionIndex,
                        teachingId == active?.teachingId &&
                            chapterIndex == active?.chapterIndex &&
                            sectionIndex == active?.sectionIndex,
                      ),
                  ],
                ),
              ),
              ContinueButton(
                label: _appState.texts.continueButton,
                onPressed: () => _onContinue(context),
              ),
            ],
          );
        },
      ),
    );
  }
}
