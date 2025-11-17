import 'package:flutter/material.dart';
import 'package:login_usuario/model/usuario.dart';
import 'package:login_usuario/services/usuario_service.dart';
import 'package:login_usuario/widgets/formulario_usuario_widget.dart';

void main() {
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
      home: FormularioUsuarioWidget(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final UsuarioService _usuarioService = UsuarioService();
  Usuario? _usuarioSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Usuario>>(
          future: _usuarioService.getUserActive(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Erro: ${snapshot.error.toString()}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text("Nenhum usuário encontrado");
            }

            final usuarios = snapshot.data!;

            return DropdownButton<Usuario>(
              hint: const Text("Selecione um usuário"),
              value: _usuarioSelecionado,
              items:
                  usuarios.map((usuario) {
                    return DropdownMenuItem<Usuario>(
                      value: usuario,
                      child: Text(usuario.nome),
                    );
                  }).toList(),
              onChanged: (Usuario? novoValor) {
                setState(() {
                  _usuarioSelecionado = novoValor;
                });
              },
            );
          },
        ),
      ),
    );
  }
}
