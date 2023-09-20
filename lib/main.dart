import 'package:caching_data_examples/entity/post_entity.dart';
import 'package:caching_data_examples/ui/first_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hiveModelsInitial();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstScreen(),
    );
  }



}

Future<void> hiveModelsInitial() async{
  await Hive.initFlutter();
  Hive.registerAdapter(PostEntityAdapter());
}
