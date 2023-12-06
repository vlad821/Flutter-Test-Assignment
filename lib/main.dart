import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';  // Import path_provider
import 'package:flutter_application_1/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initPathProvider(); // Initialize path_provider
  runApp(MyApp());
}

void initPathProvider() async {
  await getApplicationDocumentsDirectory(); // Use getApplicationDocumentsDirectory directly
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Flutter Task',
      home: MainPage(),
    );
  }
}
