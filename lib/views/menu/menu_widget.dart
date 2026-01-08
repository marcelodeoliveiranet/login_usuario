import 'package:flutter/material.dart';
import 'package:login_usuario/views/menu/meu_item_widget.dart';
import 'package:login_usuario/views/profile/profile_widget.dart';
import 'package:login_usuario/views/usuarios_cadastrados/obtenha_usuarios_cadastrados_widget.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Menu Principal"),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            spacing: 8,
            children: [
              Row(
                spacing: 8,
                children: [
                  MenuItem(
                    containerColor: Colors.green,
                    icon: Icon(Icons.person),
                    label: "Cadastro de Usuários",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ObtenhaUsuariosCadastradosWidget(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
