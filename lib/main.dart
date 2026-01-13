import 'package:college_alert_app/Screens/Auth/login_screen.dart';
import 'package:college_alert_app/Screens/Events/event_list_screen.dart';
import 'package:college_alert_app/Screens/Home/home_screen.dart';
import 'package:college_alert_app/Screens/Splash/splash_screen.dart';
import 'package:college_alert_app/Services/Notification/notification_service.dart';
import 'package:college_alert_app/Services/Notification/timezone_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:college_alert_app/Services/Notification/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.init(); // initialize local notifications
  await requestNotificationPermission();
   TimezoneHelper.init();          // ✅ timezone init
  await NotificationService.scheduleEventNotifications(events);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      home: SplashScreen(),
    );
  }
}
