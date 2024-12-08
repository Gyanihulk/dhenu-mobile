import 'package:flutter/material.dart';

class ImageWithText extends StatelessWidget {
  final String text;
  final String imagePath;
  final bool
      isImageLeft; // If true, image is on the left; otherwise, on the right.
  final Color?
      textBackgroundColor; // Optional background color for the text container
  final String? title; // Optional title

  const ImageWithText({
    super.key,
    required this.text,
    required this.imagePath,
    this.isImageLeft = true,
    this.textBackgroundColor,
    this.title, // New optional title parameter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: textBackgroundColor ?? Colors.transparent,
        ),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Vertically center the image
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (isImageLeft) _buildImage(context), // Image on the left
            Expanded(
                child: _buildTextWithTitle(
                    context)), // Text with title takes available space
            if (!isImageLeft) _buildImage(context), // Image on the right
          ],
        ));
  }

  Widget _buildImage(BuildContext context) {
  // Determine which image to use based on the background color
 

  // Conditional values based on background color
  final double imageWidth = textBackgroundColor != null
      ? MediaQuery.of(context).size.width * 0.4 // Wider when background color is present
      : MediaQuery.of(context).size.width * 0.3;

  final double imageHeight = textBackgroundColor != null
      ? MediaQuery.of(context).size.width * 0.6 // Adjust height when background color is present
      : MediaQuery.of(context).size.width * 0.3;

  final BorderRadius imageBorderRadius = textBackgroundColor != null
      ? BorderRadius.circular(0) // No rounded corners when background color is present
      : BorderRadius.circular(12.0); // Rounded corners when no background color

  return Container(
    margin:  EdgeInsets.zero,
    decoration: BoxDecoration(
      borderRadius: imageBorderRadius,
      border: Border.all(color: Colors.blueAccent, width: 2),
    ),
    child: ClipRRect(
      borderRadius: imageBorderRadius, // Apply conditional border radius to the image
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        width: imageWidth,
        height: imageHeight,
      ),
    ),
  );
}


  Widget _buildTextWithTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 21.0),
      decoration: BoxDecoration(
        color: textBackgroundColor ??
            Colors.transparent, // Apply background color if provided
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
            ),
            const SizedBox(height: 4.0), // Spacing between title and text
          ],
          Text(
            text,
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
