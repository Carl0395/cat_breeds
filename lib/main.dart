import 'package:cat_breeds/app.dart';
import 'package:cat_breeds/ui/styles/scheme/scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Scheme.colorScheme(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: scheme.primaryColor,
        ),
        fontFamily: 'Lato',
      ),
      debugShowCheckedModeBanner: false,
      home: const App(),
    );
  }
}
