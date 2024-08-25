import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/routes/my_router.dart';
import 'injection.dart';
import 'observer.dart';

void main() async {
  // INISIASI HIVE FLUTTER
  await Hive.initFlutter();
  // INISIASI INJECTION DEPEDENCIES
  await init();

  Bloc.observer = MyObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: MyRouter().router,
    );
  }
}
