import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Utility function to launch a URL
Future<void> launchURL(BuildContext context, String urlString) async {
  final Uri url = Uri.parse(urlString);

  // Check if the URL can be launched
  if (await canLaunchUrl(url)) {
    try {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      // Handle errors during URL launch
      print('Error launching URL: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open the URL')),
      );
    }
  } else {
    // Handle the case when the URL cannot be launched
    print('Cannot launch URL');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Invalid or unsupported URL')),
    );
  }
}
