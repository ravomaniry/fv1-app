import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fv1/models/section.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:fv1/providers/browser_state.dart';
import 'package:fv1/ui/routes.dart';
import 'package:fv1/ui/widgets/app_card.dart';
import 'package:fv1/ui/widgets/app_container.dart';
import 'package:fv1/ui/widgets/audio_player.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:fv1/ui/widgets/h1.dart';
import 'package:fv1/ui/widgets/loader.dart';
import 'package:fv1/ui/widgets/quote_card.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChapterScreen extends StatelessWidget {
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
      Routes.quiz,
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
    final onTap =
        isPlaying ? null : () => _state.playAudio(chapterIndex, sectionIndex);
    final colors = Theme.of(context).colorScheme;
    return AppCard(
      key: Key(sectionIndex.toString()),
      selected: isPlaying,
      padding: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: onTap,
            selected: isPlaying,
            tileColor: Colors.white,
            key: Key('PlayButton$sectionIndex'),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  section.subtitle,
                  style: _calcTitleStyle(context, isPlaying),
                ),
                _buildAudioIcon(
                  context,
                  chapterIndex,
                  sectionIndex,
                  isPlaying,
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QuoteCard(
                  borderColor: isPlaying ? colors.secondary : colors.primary,
                  child: Text(
                    section.verses,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                MarkdownBody(
                  data: section.comment,
                  key: Key('Comment$sectionIndex'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioIcon(
    BuildContext context,
    int chapterIndex,
    int sectionIndex,
    bool isPlaying,
  ) {
    return isPlaying
        ? Icon(
            Icons.surround_sound,
            color: Theme.of(context).colorScheme.primary,
            key: Key('PlayingIcon$sectionIndex'),
          )
        : const Icon(Icons.play_circle, color: Colors.black45);
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
              if (_state.playingAudio?.chapterIndex == chapterIndex)
                AudioPlayerWidget(
                  player: _state.audioPlayer,
                  texts: _appState.texts,
                ),
            ],
          );
        },
      ),
    );
  }
}
