import 'package:flutter/material.dart';
import 'boon_listview_screen.dart';
import 'sqlite.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Sqlitebase.instance.database; 
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BoonListViewScreen(),
    );
  }
}
