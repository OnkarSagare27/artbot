import 'package:artbot/screens/history_screen/hisotry_screen.dart';
import 'package:artbot/screens/settings_screen/providers/settings_provider.dart';
import 'package:artbot/screens/settings_screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen/home_screen.dart';
import 'screens/home_screen/providers/home_screen_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
    );
    return ScreenUtilInit(
        designSize: const Size(411.4, 867.4),
        splitScreenMode: true,
        builder: (_, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => HomeScreenProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => SettingsProvider(),
              ),
            ],
            child: MaterialApp(
              title: 'ArtBot',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color.fromARGB(255, 58, 62, 183)),
                useMaterial3: true,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
              debugShowCheckedModeBanner: false,
              initialRoute: "/home",
              routes: {
                "/home": (context) => const HomeScreen(),
                "/settings": (context) => const SettingsScreen(),
                "/history": (context) => const HistoryScreen(),
              },
            ),
          );
        });
  }
}
