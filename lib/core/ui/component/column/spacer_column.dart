import 'package:flutter/material.dart';

final class SpacerColumn extends StatelessWidget {
  final Widget child;
  final int spacerFlexValue;
  final int bodyFlexValue;
  const SpacerColumn({super.key, required this.child, required this.spacerFlexValue, required this.bodyFlexValue});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[ Spacer(flex: spacerFlexValue), Expanded(flex: bodyFlexValue, child: child),  Spacer(flex: spacerFlexValue)],
    );
  }
}