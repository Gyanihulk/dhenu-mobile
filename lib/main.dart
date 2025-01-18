import 'package:dhenu_dharma/data/repositories/language/language_repository.dart';
import 'package:dhenu_dharma/service/app_info.dart';
import 'package:dhenu_dharma/service/app_preferences.dart';
import 'package:dhenu_dharma/utils/localization/app_localizations.dart';
import 'package:dhenu_dharma/utils/providers/auth_provider.dart';
import 'package:dhenu_dharma/utils/providers/language_provider.dart';
import 'package:dhenu_dharma/views/app.dart';
import 'package:dhenu_dharma/views/screens/initial/initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:app_links/app_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

/// Initialize Firebase Messaging and Notifications
Future<void> setupFCM() async {
NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

  // Create a notification channel for Android
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // ID for the channel
    'High Importance Notifications', // Channel name
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Set up local notifications for Android
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // Configure foreground notification presentation for iOS
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // Get FCM Token for the device (for testing purposes)
  String? token = await FirebaseMessaging.instance.getToken();
  print("FCM Token from push notification: $token");

  // Handle background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Handle foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _showNotification(message);
  });

  // Handle notification taps when the app is opened from the terminated state
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      print("App opened from terminated state: ${message.notification?.title}");
    }
  });

  // Handle notification taps when the app is in the background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("Notification tapped: ${message.notification?.title}");
  });
}

/// Background Message Handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCi4YpFIV58HfoS3806T_aUO29KIMUxsbY",
      appId: "1:336065761387:android:2a1399f6db0d47e278612e",
      messagingSenderId: "336065761387",
      projectId: "dhenu-dharma",
      storageBucket: "dhenu-dharma.firebasestorage.app",
    ),
  );

  print("Handling a background message: ${message.notification?.title}");
  print("Full background message: ${message.toMap()}");
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = notification?.android;

  if (notification != null && android != null) {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // Same as your notification channel ID
      'High Importance Notifications', // Name of the channel
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    // Ensure the notification channel is created
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Show the notification
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@mipmap/ic_launcher', // Your app icon
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        ),
      ),
    );
  }
}

/// Show a notification for foreground messages
void _showNotification(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  print(
      "Handling a background message _showNotification: ${message.notification?.title}");
  print("Full notification payload: ${message.toMap()}");

  if (notification != null && android != null) {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'high_importance_channel', // Channel ID
      'High Importance Notifications', // Channel Name
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker', // Optional: Adds a ticker to the notification
      playSound: true,
      icon: '@mipmap/ic_launcher', // Your app's launcher icon
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      notification.hashCode, // Unique ID for the notification
      notification.title ?? 'No Title', // Notification title
      notification.body ?? 'No Body', // Notification body
      notificationDetails,
      payload: message.data.isNotEmpty ? message.data.toString() : null, // Payload data (if any)
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCi4YpFIV58HfoS3806T_aUO29KIMUxsbY",
      appId: "1:336065761387:android:2a1399f6db0d47e278612e",
      messagingSenderId: "336065761387",
      projectId: "dhenu-dharma",
      storageBucket: "dhenu-dharma.firebasestorage.app",
    ),
  );

  // Initialize shared preferences
  await AppPreferences.instance.initSharedPreferences();

  // Initialize repositories
  final languageRepository = LanguageRepository();

  // Initialize AuthProvider
  final authProvider = AuthProvider(languageRepository: languageRepository);

  // Load user data
  await authProvider.loadUserData();

  // Initialize LanguageProvider
  final languageProvider = LanguageProvider(
    languageRepository: languageRepository,
    authProvider: authProvider,
  );

  // Fetch languages (ensure proper initialization)
  await languageProvider.fetchLanguages();

  initDeepLinkListener();

  final appInfo = AppInfo();
  await appInfo.initialize();
  await setupFCM();
  runApp(AppLocalizationState(
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authProvider),
        ChangeNotifierProvider(create: (_) => languageProvider),
      ],
      child: MyApp(authProvider: authProvider),
    ),
  ));
}

void initDeepLinkListener() {
  final appLinks = AppLinks();
  appLinks.uriLinkStream.listen((Uri? uri) {
    if (uri != null) {
      print('Received deep link: $uri');

      if (uri.scheme == 'gyanitech.dhenudharma' &&
          uri.host == 'payment-callback') {
        final invoiceId =
            uri.queryParameters['razorpay_invoice_id'] ?? "Unknown";
        final paymentId =
            uri.queryParameters['razorpay_payment_id'] ?? "Unknown";
        final status =
            uri.queryParameters['razorpay_invoice_status'] ?? "Unknown";

        if (status == 'paid') {
          print(
              'Payment successful! Invoice ID: $invoiceId, Payment ID: $paymentId');

          WidgetsBinding.instance.addPostFrameCallback((_) {
            // Access navigator context to show SnackBar and navigate
            final context = MyApp.navigatorKey.currentContext!;

            // Show success SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Payment Successful! 🎉\nInvoice ID: $invoiceId\nPayment ID: $paymentId",
                ),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 5),
              ),
            );

            // Navigate to the InitialScreen with home page selected
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const InitialScreen(pageIndex: 0)),
              (route) => false,
            );
          });
        } else {
          print('Payment failed. Status: $status');

          WidgetsBinding.instance.addPostFrameCallback((_) {
            final context = MyApp.navigatorKey.currentContext!;

            // Show failure SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Payment Failed. Please try again.\nInvoice ID: $invoiceId",
                ),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 5),
              ),
            );

            // Navigate to InitialScreen (optional, if required for failed payments)
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const InitialScreen(pageIndex: 0)),
              (route) => false,
            );
          });
        }
      }
    }
  }, onError: (err) {
    print('Failed to handle deep link: $err');
  });
}
