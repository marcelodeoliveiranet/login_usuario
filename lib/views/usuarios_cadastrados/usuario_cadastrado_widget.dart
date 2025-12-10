import 'package:flutter/material.dart';
import 'package:login_usuario/controllers/usuario_controller.dart';
import 'package:login_usuario/model/usuario_cadastrado.dart';
import 'package:login_usuario/views/formulario_usuario/formulario_usuario_widget.dart';

class UsuarioCadastradoWidget extends StatefulWidget {
  final UsuarioCadastrado usuario;
  final UsuarioController usuarioController;

  const UsuarioCadastradoWidget({
    super.key,
    required this.usuario,
    required this.usuarioController,
  });

  @override
  State<UsuarioCadastradoWidget> createState() =>
      _UsuarioCadastradoWidgetState();
}

class _UsuarioCadastradoWidgetState extends State<UsuarioCadastradoWidget> {
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
                "Nome: ${widget.usuario.nome}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text("Código: ${widget.usuario.codigo}"),
              Text("Ativo: ${widget.usuario.ativo}"),
              Text("Administrador: ${widget.usuario.administrador}"),
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
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ButtonStyle(),
                                    child: Text(
                                      "Cancelar",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      widget.usuarioController.excluirUsuario(
                                        widget.usuario,
                                      );
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
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => FormularioUsuarioWidget(
                            isEditing: true,
                            usuario: widget.usuario,
                          ),
                    ),
                  );
                },
                icon: Icon(Icons.edit),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
