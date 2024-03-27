import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double dynamicWidth(double val) => MediaQuery.of(this).size.width * val;
  double dynamicHeight(double val) => MediaQuery.of(this).size.height * val;
  ThemeData get theme => Theme.of(this);
}

extension NumberExtension on BuildContext {
  double get lowValue => dynamicHeight(0.1);
  double get minimalValue => dynamicHeight(0.07);
  double get minValue => dynamicHeight(0.08);
  double get minSpaceValue => dynamicHeight(0.05);
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingAllLow => EdgeInsets.all(lowValue);
}

extension MinSpaceWidget on BuildContext {
  Widget get spaceLowValue => const SizedBox(
    width: 10,
  );
}

extension MediumSpaceWidget on BuildContext {
  Widget get spaceMediumValue => SizedBox(
    height: dynamicHeight(0.01),
  );
}


extension DefaultSpaceWidget on BuildContext {
  Widget get spaceDefaultValue => SizedBox(
    height: dynamicHeight(0.02),
  );
}



extension MediumWidthSpaceWidget on BuildContext {
  Widget get widthSpaceMediumValue => SizedBox(
    width: dynamicHeight(0.02),
  );
}

extension ExpandedSpaceWidget on BuildContext {
  Widget get expandedSpace => const Expanded(flex: 1,child: SizedBox.shrink(),);
}

extension ImagePathExtension on String {
  String get toJPG=> 'assets/$this.jpg';
}


