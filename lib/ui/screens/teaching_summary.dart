import 'package:flutter/material.dart';
import 'package:fv1/models/chapter.dart';
import 'package:fv1/providers/browser_state.dart';
import 'package:fv1/ui/screens/chapter.dart';
import 'package:fv1/ui/widgets/app_container.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:fv1/ui/widgets/h1.dart';
import 'package:fv1/ui/widgets/loader.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TeachingSummaryScreen extends StatelessWidget {
  final int id;
  static const route = '/teaching';

  const TeachingSummaryScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<BrowserState>(
        builder: (_, state, __) => _ScreenBody(state, id));
  }
}

class _ScreenBody extends StatefulWidget {
  final BrowserState _state;
  final int _teachingId;

  const _ScreenBody(this._state, this._teachingId);

  @override
  State<_ScreenBody> createState() => _ScreenBodyState();
}

class _ScreenBodyState extends State<_ScreenBody> {
  int? _prevId;

  void _onContinue() {
    _onOpenChapter(0);
  }

  void _onOpenChapter(int chapterIndex) {
    context.goNamed(
      ChapterScreen.route,
      pathParameters: {
        'id': widget._teachingId.toString(),
        'chapterIndex': chapterIndex.toString(),
      },
    );
  }

  void _loadTeaching() {
    widget._state.loadTeaching(widget._teachingId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget._teachingId != _prevId) {
      _prevId = widget._teachingId;
      _loadTeaching();
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
            ContinueButton(onPressed: _onContinue),
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
