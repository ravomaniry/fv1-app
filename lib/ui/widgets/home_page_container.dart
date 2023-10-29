import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fv1/ui/widgets/responsive_padding.dart';

class HomePageContainer extends StatelessWidget {
  final Widget body;
  final Widget? floatingActionButton;
  final List<Widget>? appBarActions;

  const HomePageContainer({
    super.key,
    required this.body,
    this.floatingActionButton,
    this.appBarActions,
  });

  double _calcColoredBoxHeight(Size size) {
    return size.height * 0.4;
  }

  Widget _buildColoredContainer(Size size, ThemeData theme) {
    return Container(
      height: _calcColoredBoxHeight(size),
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [theme.primaryColor, theme.primaryColorDark],
        ),
      ),
    );
  }

  Widget _buildSmallCircle(Size size) {
    final diameter = min(size.height, size.width) * 0.15;
    const double margin = 16;
    const alpha = 30;
    return Positioned(
      left: margin,
      top: _calcColoredBoxHeight(size) - diameter - margin,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(alpha),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildBigCircle(Size size) {
    final diameter = min(size.height, size.width) * 0.4;
    const double margin = 16;
    const alpha = 20;
    return Positioned(
      right: margin,
      top: margin,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(alpha),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildAppName(Size size, ThemeData theme) {
    const fontFamily = 'JbMono';
    return SizedBox(
      width: size.width,
      height: _calcColoredBoxHeight(size),
      child: ResponsivePadding(
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'fitiavana',
                style: TextStyle(
                  fontSize: 48,
                  fontFamily: fontFamily,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 4,
                  bottom: 4,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                ),
                child: const Text(
                  'voalohany',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: fontFamily,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarAction() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: appBarActions!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final coloredBoxHeight = size.height * 0.4;
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: floatingActionButton,
      body: Stack(
        children: [
          _buildColoredContainer(size, theme),
          _buildSmallCircle(size),
          _buildBigCircle(size),
          _buildAppName(size, theme),
          SizedBox(
            width: size.width,
            height: size.height,
            child: ResponsivePadding(
              child: Column(
                children: [
                  if (appBarActions != null) _buildAppBarAction(),
                  SizedBox(height: coloredBoxHeight + 16),
                  body,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
