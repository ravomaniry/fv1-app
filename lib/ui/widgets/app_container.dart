import 'package:flutter/material.dart';
import 'package:fv1/ui/widgets/app_bar.dart';

class AppContainer extends StatelessWidget {
  final Widget body;
  final bool backButton;
  final Key? backButtonKey;
  final Widget? floatingActionButton;

  const AppContainer({
    super.key,
    required this.body,
    this.floatingActionButton,
    required this.backButton,
    this.backButtonKey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, backButton, backButtonKey),
      floatingActionButton: floatingActionButton,
      body: Container(
        padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SafeArea(child: body),
      ),
    );
  }
}
