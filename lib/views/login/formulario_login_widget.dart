import 'package:flutter/material.dart';
import 'package:login_usuario/controllers/login_controller.dart';
import 'package:login_usuario/controllers/usuario_controller.dart';
import 'package:login_usuario/dependencies/injetor.dart';
import 'package:login_usuario/dto/request/login_request.dart';
import 'package:login_usuario/model/usuario.dart';
import 'package:login_usuario/views/usuarios_cadastrados/obtenha_usuarios_cadastrados_widget.dart';

class FormularioLoginWidget extends StatefulWidget {
  const FormularioLoginWidget({super.key});

  @override
  State<FormularioLoginWidget> createState() => _FormularioLoginWidgetState();
}

class _FormularioLoginWidgetState extends State<FormularioLoginWidget> {
  final senhaController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  LoginController loginController = getIt<LoginController>();
  Usuario? usuarioSelecionado;
  UsuarioController usuarioController = UsuarioController();

  void verificarUsuarioLogado() {
    if (loginController.usuarioLogado != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ObtenhaUsuariosCadastradosWidget(),
        ),
        (route) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    usuarioController.obtenhaUsuariosAtivos();
    loginController.verficarUsuarioLogado();
    loginController.addListener(verificarUsuarioLogado);
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                          onPressed: () async {
                            final validation = formKey.currentState?.validate();

                            if (validation == true) {
                              LoginRequest loginRequest = LoginRequest(
                                codigoUsuario: usuarioSelecionado!.codigo,
                                senha: senhaController.text,
                              );
                              await loginController.logarUsuario(loginRequest);
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

  @override
  void dispose() {
    loginController.removeListener(verificarUsuarioLogado);
    super.dispose();
  }
}
