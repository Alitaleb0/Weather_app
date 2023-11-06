import 'package:flutter/material.dart';
//import 'package:Weather_app/pages/weather_page.dart';
import 'pages/weather_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { /*إdebugShowCheckedModeBanner لأخفاء شعار "DEBUG" الذي يظهر في الزاوية */
    return const MaterialApp(debugShowCheckedModeBanner: false, // لأزالة الشريط
      home: WeatherPage(),
    );
  }
}

