import 'package:flutter/material.dart';
import 'package:fv1/ui/widgets/app_bar.dart';

class AppContainer extends StatelessWidget {
  final Widget body;
  final Widget? floatingActionButton;

  const AppContainer(
      {super.key, required this.body, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      floatingActionButton: floatingActionButton,
      body: Container(
        padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
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
