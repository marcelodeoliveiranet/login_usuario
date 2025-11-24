import 'package:flutter/material.dart';
import 'package:login_usuario/model/obtenha_usuarios_cadastrados.dart';

class UsuarioCadastradoWidget extends StatelessWidget {
  final Obtenhausuarioscadastrados usuario;
  const UsuarioCadastradoWidget({super.key, required this.usuario});

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
      child: Column(
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
    );
  }
}
