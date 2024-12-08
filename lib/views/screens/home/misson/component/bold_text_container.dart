import 'package:flutter/material.dart';

class BoldTextContainer extends StatelessWidget {
  final String text;
  final String boldIdentifier;

  const BoldTextContainer({
    super.key,
    required this.text,
    required this.boldIdentifier,
  });

  @override
  Widget build(BuildContext context) {
    final words = text.split(' ');

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
        children: words.map((word) {
          bool isBold = word.contains(boldIdentifier);
          return TextSpan(
            text: '$word ', // Add a space after each word
            style: isBold
                ? const TextStyle(fontWeight: FontWeight.bold)
                : const TextStyle(fontWeight: FontWeight.normal),
          );
        }).toList(),
      ),
    );
  }
}
