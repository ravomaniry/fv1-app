import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fv1/extensions/context.dart';
import 'package:fv1/ui/widgets/app_card.dart';
import 'package:fv1/ui/widgets/h2.dart';

class AssetImageWithDescription extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;
  final bool isMarkdown;

  const AssetImageWithDescription({
    super.key,
    required this.title,
    required this.imagePath,
    required this.description,
    this.isMarkdown = false,
  });

  Widget _buildDescription() {
    return isMarkdown ? MarkdownBody(data: description) : Text(description);
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ScreenH2(title, color: context.themePrimaryColor),
          Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: context.themePrimaryColor, width: 2),
              ),
            ),
            child: Image(
              image: AssetImage(imagePath),
              alignment: Alignment.topLeft,
              fit: BoxFit.fitWidth,
            ),
          ),
          _buildDescription(),
        ],
      ),
    );
  }
}
