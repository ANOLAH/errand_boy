import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final messengerKey = GlobalKey<ScaffoldMessengerState>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: messengerKey,
      title: 'ERRAND BOY',
      theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 31, 44, 52),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: const Color.fromARGB(255, 2, 168, 132))),
      home: const Wrapper(),
    );
  }
}
