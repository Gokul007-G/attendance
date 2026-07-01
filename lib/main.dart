import 'package:attendance/core/constant/appColors.dart';
import 'package:attendance/core/utils/local_data_store.dart';
import 'package:attendance/di/locator.dart';
import 'package:attendance/features/login/presentation/provider/login_provider.dart';
import 'package:attendance/features/splash/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future< void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.instance.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // Android → white icons
      statusBarBrightness: Brightness.dark, // iOS → white icons
    ),
  );

  setLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => locator<LoginProvider>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Attendance App',

        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: appBackground),
          appBarTheme: const AppBarTheme(
            backgroundColor: secondaryBlue,
            foregroundColor: white,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            ),
          ),
          cardTheme: CardThemeData(
            
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 32.0,
              ),
              textStyle: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: accentGreen,
              foregroundColor: white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        home: Splashscreen(),
      ),
    );
  }
}
