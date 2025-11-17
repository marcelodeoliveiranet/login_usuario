import 'package:flutter/material.dart';
import 'package:login_usuario/controllers/usuario_controller.dart';
import 'package:login_usuario/dto/request/cadastrar_usuario_request.dart';
import 'package:login_usuario/model/perfil_acesso.dart';
import 'package:login_usuario/services/usuario_service.dart';

class FormularioUsuarioWidget extends StatefulWidget {
  const FormularioUsuarioWidget({super.key});

  @override
  State<FormularioUsuarioWidget> createState() =>
      _FormularioUsuarioWidgetState();
}

class _FormularioUsuarioWidgetState extends State<FormularioUsuarioWidget> {
  final nomeController = TextEditingController();
  final senhaController = TextEditingController();
  final emailController = TextEditingController();
  UsuarioController usuarioController = UsuarioController();
  UsuarioService usuarioService = UsuarioService();
  bool ativo = false;
  bool administrador = false;
  bool possuiNecessidadeEspeciais = false;
  PerfilAcesso? perfilSelecionado;
  final formKey = GlobalKey<FormState>();
  final dropdownKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    usuarioController.buscarPerfilAcesso();
  }

  Future<void> validarFormulario(
    String nome,
    String senha,
    bool ativo,
    bool administrador,
    bool possuiNecessidadeEspeciais,
    int codigoPerfilAcesso,
    String email,
  ) async {
    CadastrarUsuarioRequest cadastrarUsuario = CadastrarUsuarioRequest(
      codigo: 0,
      foto: "",
      nome: nome,
      senha: senha,
      ativo: (ativo ? "S" : "N"),
      administrador: (administrador ? "S" : "N"),
      necessidadeEspecial: (possuiNecessidadeEspeciais ? "S" : "N"),
      codigoPerfil: perfilSelecionado!.codigo,
      email: email,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(content: Center(child: CircularProgressIndicator()));
      },
    );

    try {
      await usuarioService.saveUser(cadastrarUsuario);

      nomeController.clear();
      senhaController.clear();
      emailController.clear();
      perfilSelecionado = null;
      ativo = false;
      administrador = false;
      possuiNecessidadeEspeciais = false;
      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Usuário cadastrado com sucesso"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    } finally {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro de Usuarios")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListenableBuilder(
          listenable: usuarioController,
          builder: (context, child) {
            return Form(
              key: formKey,
              child: Column(
                spacing: 16,
                children: [
                  TextFormField(
                    controller: nomeController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Nome"),
                    ),
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "Preencha o nome";
                      }

                      return null;
                    },
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

                  CheckboxListTile(
                    key: GlobalKey(),
                    title: const Text("Ativo?"),
                    value: ativo,
                    onChanged: (bool? valor) {
                      setState(() {
                        ativo = valor ?? false;
                      });
                    },
                  ),

                  CheckboxListTile(
                    key: GlobalKey(),
                    title: const Text("Será um administrador? "),
                    value: administrador,
                    onChanged: (bool? valor) {
                      setState(() {
                        administrador = valor ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    key: GlobalKey(),
                    title: const Text("Possui necessidade especiais?"),
                    value: possuiNecessidadeEspeciais,
                    onChanged: (bool? valor) {
                      setState(() {
                        possuiNecessidadeEspeciais = valor ?? false;
                      });
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<PerfilAcesso>(
                          key: dropdownKey,
                          decoration: const InputDecoration(
                            labelText: 'Selecione um perfil',
                            border: OutlineInputBorder(),
                          ),
                          isExpanded: true,
                          value: perfilSelecionado,
                          items:
                              usuarioController.perfisAcesso.map((
                                perfilacesso,
                              ) {
                                return DropdownMenuItem<PerfilAcesso>(
                                  value: perfilacesso,
                                  child: Text(perfilacesso.descricao),
                                );
                              }).toList(),
                          validator: (value) {
                            if (value == null) {
                              return "Selecione um perfil de acesso";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              perfilSelecionado = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            perfilSelecionado = null;
                            setState(() {});
                          },
                          icon: Icon(Icons.clear),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Email"),
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            final validation = formKey.currentState?.validate();

                            if (validation == true) {
                              final String nome = nomeController.text;
                              final String senha = senhaController.text;
                              final String email = emailController.text;

                              validarFormulario(
                                nome,
                                senha,
                                ativo,
                                administrador,
                                possuiNecessidadeEspeciais,
                                perfilSelecionado!.codigo,
                                email,
                              );
                            }
                          },
                          child: const Text("Gravar"),
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
    nomeController.dispose();
    senhaController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
