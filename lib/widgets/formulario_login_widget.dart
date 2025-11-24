import 'package:flutter/material.dart';
import 'package:login_usuario/controllers/usuario_controller.dart';
import 'package:login_usuario/model/usuario.dart';
import 'package:login_usuario/widgets/obtenha_usuarios_cadastrados_widget.dart';

class FormularioLoginWidget extends StatefulWidget {
  const FormularioLoginWidget({super.key});

  @override
  State<FormularioLoginWidget> createState() => _FormularioLoginWidgetState();
}

class _FormularioLoginWidgetState extends State<FormularioLoginWidget> {
  final senhaController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Usuario? usuarioSelecionado;
  UsuarioController usuarioController = UsuarioController();

  @override
  void initState() {
    super.initState();
    usuarioController.obtenhaUsuariosAtivos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListenableBuilder(
          listenable: usuarioController,
          builder: (context, child) {
            return Form(
              key: formKey,
              child: Column(
                spacing: 16,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<Usuario>(
                          decoration: const InputDecoration(
                            labelText: 'Selecione um usuário',
                            border: OutlineInputBorder(),
                          ),
                          isExpanded: true,
                          value: usuarioSelecionado,
                          items:
                              usuarioController.usuariosAtivos.map((usuario) {
                                return DropdownMenuItem<Usuario>(
                                  value: usuario,
                                  child: Text(usuario.nome),
                                );
                              }).toList(),
                          validator: (value) {
                            if (value == null) {
                              return "Selecione um usuario";
                            }

                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              usuarioSelecionado = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: senhaController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Senha"),
                    ),
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "Preencha a senha";
                      }

                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final validation = formKey.currentState?.validate();

                            if (validation == true) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          ObtenhaUsuariosCadastradosWidget(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            minimumSize: Size(200, 50),
                          ),
                          child: const Text("Logar"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
