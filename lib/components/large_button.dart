import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  final String label;
  final String? image;
  final void Function()? onPressed;

  const LargeButton({
    super.key,
    required this.label,
    this.image,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(32);

    return Material(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Ink(
          height: 64,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                offset: const Offset(1, 3),
                blurRadius: 7,
                spreadRadius: .3,
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Theme.of(context).colorScheme.outlineVariant,
                Theme.of(context).colorScheme.secondaryContainer,
              ],
            ),
          ),
          child: InkWell(
            borderRadius: borderRadius,
            splashColor: Theme.of(context).colorScheme.onPrimary,
            onTap: onPressed,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (image != null) Image.asset(image!),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
