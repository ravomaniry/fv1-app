import 'package:flutter/widgets.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:fv1/ui/routes.dart';
import 'package:fv1/ui/widgets/app_container.dart';
import 'package:fv1/ui/widgets/asset_image_with_description.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:fv1/ui/widgets/h1.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HelpScreen extends StatelessWidget {
  static const widgetKey = Key('HelpScreen');

  const HelpScreen({super.key});

  void _onClose(BuildContext context) {
    context.goNamed(Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    final appTexts = context.watch<AppState>().texts;
    final items = [
      _HelpItem(
        appTexts.helpLoginTitle,
        appTexts.helpLoginDescription,
        'assets/images/help-login.png',
      ),
      _HelpItem(
        appTexts.helpHomeTitle,
        appTexts.helpHomeDescription,
        'assets/images/help-home.png',
      ),
      _HelpItem(
        appTexts.helpTeachingSummaryTitle,
        appTexts.helpTeachingSummaryDescription,
        'assets/images/help-teaching.png',
      ),
      _HelpItem(
        appTexts.helpChapterTitle,
        appTexts.helpChapterDescription,
        'assets/images/help-chapter.png',
      ),
      _HelpItem(
        appTexts.helpQuizTitle,
        appTexts.helpQuizDescription,
        'assets/images/help-quiz.png',
      ),
    ];
    return AppContainer(
      backButton: true,
      body: SingleChildScrollView(
        child: Column(
          key: HelpScreen.widgetKey,
          children: [
            ScreenH1(appTexts.helpTitle),
            for (final item in items)
              AssetImageWithDescription(
                title: item._title,
                description: item._description,
                imagePath: item._imagePath,
                isMarkdown: true,
              ),
            const SizedBox(height: 8),
            ContinueButton(
              label: appTexts.close,
              onPressed: () => _onClose(context),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _HelpItem {
  final String _title;
  final String _description;
  final String _imagePath;

  const _HelpItem(this._title, this._description, this._imagePath);
}
