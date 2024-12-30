import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

class DeepLinkHandler {
  void initDeepLinkListener(BuildContext context) {
    uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        print('Received deep link: $uri');

        if (uri.scheme == 'gyanitech.dhenu_dharma' && uri.host == 'payment-callback') {
          final status = uri.queryParameters['status'];
          final transactionId = uri.queryParameters['transaction_id'];

          if (status == 'success') {
            print('Payment successful! Transaction ID: $transactionId');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Payment successful!')),
            );
          } else {
            print('Payment failed.');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Payment failed!')),
            );
          }
        }
      }
    }, onError: (err) {
      print('Failed to handle deep link: $err');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to handle deep link: $err')),
      );
    });
  }
}
