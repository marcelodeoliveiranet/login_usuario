import 'package:flutter/material.dart';
import 'package:login_usuario/controllers/usuario_controller.dart';
import 'package:login_usuario/model/obtenha_usuarios_cadastrados.dart';

class UsuarioCadastradoWidget extends StatelessWidget {
  final Obtenhausuarioscadastrados usuario;
  final UsuarioController usuarioController;

  const UsuarioCadastradoWidget({
    super.key,
    required this.usuario,
    required this.usuarioController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Color(0XFFFFEDC2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nome: ${usuario.nome}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text("Código: ${usuario.codigo}"),
              Text("Ativo: ${usuario.ativo}"),
              Text("Administrador: ${usuario.administrador}"),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: IntrinsicHeight(
                          child: Column(
                            children: [
                              Text(
                                "Você deseja remover esse usuário?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    style: ButtonStyle(),
                                    child: Text(
                                      "Cancelar",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      usuarioController.excluirUsuario(usuario);
                                    },
                                    child: Text(
                                      "Excluir",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: Icon(Icons.delete),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
            ],
          ),
        ],
      ),
    );
  }
}
