import 'package:flutter/material.dart';
import 'package:login_usuario/dependencies/injetor.dart';
import 'package:login_usuario/views/login/formulario_login_widget.dart';

void main() {
  setupInjector();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Usuario',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FormularioLoginWidget(),
    );
  }
}
