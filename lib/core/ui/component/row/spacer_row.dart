import 'package:flutter/material.dart';

final class SpacerRow extends StatelessWidget {
  final Widget child;
  final int spacerFlexValue;
  final int bodyFlexValue;
  const SpacerRow({super.key, required this.child, required this.spacerFlexValue, required this.bodyFlexValue});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[ Spacer(flex: spacerFlexValue), Expanded(flex: bodyFlexValue, child: child),  Spacer(flex: spacerFlexValue)],
    );
  }
}