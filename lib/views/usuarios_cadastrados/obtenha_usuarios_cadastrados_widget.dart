import 'package:flutter/material.dart';
import 'package:login_usuario/controllers/usuario_controller.dart';
import 'package:login_usuario/dependencies/injetor.dart';
import 'package:login_usuario/model/usuario_cadastrado.dart';
import 'package:login_usuario/states/base_state.dart';
import 'package:login_usuario/views/formulario_usuario/formulario_usuario_widget.dart';
import 'package:login_usuario/views/profile/profile_widget.dart';
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
    usuarioController.excluirUsuarioState.addListener(onExcluirUsuario);
  }

  void onExcluirUsuario() {
    final value = usuarioController.excluirUsuarioState.value;

    if (value is ErrorState) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: IntrinsicHeight(
              child: Column(
                spacing: 16,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 45),
                  Text(value.erro, style: TextStyle(fontSize: 24)),
                ],
              ),
            ),
          );
        },
      );
    } else if (value is LoadingState) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: IntrinsicHeight(
              child: Column(
                spacing: 16,
                children: [CircularProgressIndicator()],
              ),
            ),
          );
        },
      );
    } else {
      Navigator.of(context).pop();
      if (value is SuccessState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(value.sucesso), backgroundColor: Colors.green),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuários Cadastrados"),
        backgroundColor: Colors.blue,
        actions: [
          CircleAvatar(
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileWidget()),
                );
              },
              icon: Icon(Icons.person),
            ),
          ),
        ],
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

  @override
  void dispose() {
    usuarioController.usuarioState.removeListener(onExcluirUsuario);
    super.dispose();
  }
}
