import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/api_provider.dart';
import 'router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApiProvider(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Yu-Gi-Oh! App',
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
