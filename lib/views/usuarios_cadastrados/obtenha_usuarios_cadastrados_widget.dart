import 'package:flutter/material.dart';
import 'package:login_usuario/controllers/usuario_controller.dart';
import 'package:login_usuario/dependencies/injetor.dart';
import 'package:login_usuario/model/obtenha_usuarios_cadastrados.dart';
import 'package:login_usuario/views/formulario_usuario/formulario_usuario_widget.dart';
import 'package:login_usuario/views/usuarios_cadastrados/usuario_cadastrado_widget.dart';

class ObtenhaUsuariosCadastradosWidget extends StatefulWidget {
  const ObtenhaUsuariosCadastradosWidget({super.key});

  @override
  State<ObtenhaUsuariosCadastradosWidget> createState() =>
      _ObtenhaUsuariosCadastradosWidgetState();
}

class _ObtenhaUsuariosCadastradosWidgetState
    extends State<ObtenhaUsuariosCadastradosWidget> {
  final UsuarioController usuarioController = getIt<UsuarioController>();

  @override
  void initState() {
    super.initState();
    usuarioController.obterUsuariosCadastrados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuários Cadastrados"),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormularioUsuarioWidget(isEditing: false),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: RefreshIndicator(
          onRefresh: usuarioController.obterUsuariosCadastrados,
          child: ListenableBuilder(
            listenable: usuarioController,
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: usuarioController.usuariosCadastrados.length,
                itemBuilder: (context, index) {
                  UsuarioCadastrado usuario =
                      usuarioController.usuariosCadastrados[index];
                  return UsuarioCadastradoWidget(
                    usuario: usuario,
                    usuarioController: usuarioController,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
