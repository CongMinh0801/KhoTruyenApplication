import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:lang_s_application4/theme/theme_helper.dart';
import 'package:lang_s_application4/routes/app_routes.dart';
import 'book_data.dart';
import 'user_data.dart'; // Import the file where UserData is defined
// Import BookData if you plan to use it in your app

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Create providers for UserData and BookData if needed
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserData()),
        ChangeNotifierProvider(create: (context) => BookData()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'Kho Truyện',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeContainerScreen,
      routes: AppRoutes.routes,
    );
  }
}
