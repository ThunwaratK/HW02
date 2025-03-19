import 'package:cp_213_sqflife_thunwarat/boon_listview_screen.dart';
import 'package:cp_213_sqflife_thunwarat/sqflite_database.dart';
import 'package:flutter/material.dart';
import 'package:cp_213_sqflife_thunwarat/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize databaseFactory for desktop platforms
  if (SqfliteDatabase.isDesktopPlatform()) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  SqfliteDatabase service =
      SqfliteDatabase(); // Initialize the database service
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: BoonListViewScreen())),
    );
  }
}
