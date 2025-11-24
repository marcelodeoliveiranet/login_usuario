import 'package:flutter/material.dart';
import 'package:login_usuario/model/obtenha_usuarios_cadastrados.dart';
import 'package:login_usuario/services/usuario_service.dart';
import 'package:login_usuario/widgets/formulario_usuario_widget.dart';
import 'package:login_usuario/widgets/usuario_cadastrado_widget.dart';

class ObtenhaUsuariosCadastradosWidget extends StatefulWidget {
  const ObtenhaUsuariosCadastradosWidget({super.key});

  @override
  State<ObtenhaUsuariosCadastradosWidget> createState() =>
      _ObtenhaUsuariosCadastradosWidgetState();
}

class _ObtenhaUsuariosCadastradosWidgetState
    extends State<ObtenhaUsuariosCadastradosWidget> {
  Future<List<Obtenhausuarioscadastrados>> _futureObtenhaUsuariosCadastrados =
      UsuarioService().obtenhaUsuariosCadastrados();

  Future<void> refreshObtenhaUsuariosCadastrados() async {
    setState(() {
      _futureObtenhaUsuariosCadastrados =
          UsuarioService().obtenhaUsuariosCadastrados();
    });
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
          FormularioUsuarioWidget();
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: RefreshIndicator(
          onRefresh: refreshObtenhaUsuariosCadastrados,
          child: FutureBuilder(
            future: _futureObtenhaUsuariosCadastrados,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  {
                    if (snapshot.data == null || snapshot.data!.isEmpty) {
                      return const Text("Nenhum usuário cadastrado");
                    } else {
                      List<Obtenhausuarioscadastrados> usuariosCadastrados =
                          snapshot.data!;
                      return ListView.builder(
                        itemCount: usuariosCadastrados.length,
                        itemBuilder: (context, index) {
                          Obtenhausuarioscadastrados usuario =
                              usuariosCadastrados[index];
                          return UsuarioCadastradoWidget(usuario: usuario);
                        },
                      );
                    }
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
