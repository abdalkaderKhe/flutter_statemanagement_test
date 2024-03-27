import 'package:flutter/material.dart';

final class MainButton extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const MainButton ({super.key, required this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: DecoratedBox(
        decoration:
        const BoxDecoration(color: Colors.red),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
