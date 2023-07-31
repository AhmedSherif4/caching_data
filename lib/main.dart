import 'package:caching_data_examples/ui/first_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(
    const MaterialApp(
      home:FirstScreen() ,
    ),
  );
}
