import 'package:flutter/material.dart';

import 'cores/cores_fam.dart';

class FamAcademico extends StatelessWidget {
  const FamAcademico({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Fam Acadêmico',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: laranja),
      scaffoldBackgroundColor: const Color(0xFFF7F7F8),
      appBarTheme: const AppBarTheme(
        backgroundColor: preto,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: const InputDecoration(border: OutlineInputBorder()),
    ),
    initialRoute: '/login',
    routes: {'/login': (_) => const LoginPage()},
  );
}
