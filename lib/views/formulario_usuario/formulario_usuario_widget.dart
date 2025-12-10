import 'package:flutter/material.dart';
import 'package:login_usuario/controllers/usuario_controller.dart';
import 'package:login_usuario/dependencies/injetor.dart';
import 'package:login_usuario/dto/request/cadastrar_usuario_request.dart';
import 'package:login_usuario/model/perfil_acesso.dart';
import 'package:login_usuario/model/usuario_cadastrado.dart';
import 'package:login_usuario/states/base_state.dart';

class FormularioUsuarioWidget extends StatefulWidget {
  final bool isEditing;
  final UsuarioCadastrado? usuario;

  const FormularioUsuarioWidget({
    super.key,
    required this.isEditing,
    this.usuario,
  });

  @override
  State<FormularioUsuarioWidget> createState() =>
      _FormularioUsuarioWidgetState();
}

class _FormularioUsuarioWidgetState extends State<FormularioUsuarioWidget> {
  final nomeController = TextEditingController();
  final senhaController = TextEditingController();
  final emailController = TextEditingController();

  UsuarioController usuarioController = getIt<UsuarioController>();
  int codigo = 0;
  bool ativo = false;
  bool administrador = false;
  bool possuiNecessidadeEspeciais = false;
  PerfilAcesso? perfilSelecionado;
  final formKey = GlobalKey<FormState>();
  final dropdownKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) setupEditingUser();
    usuarioController.buscarPerfilAcesso();
    usuarioController.salvarUsuarioState.addListener(onSalvarUsuario);
  }

  void setupEditingUser() {
    codigo = widget.usuario!.codigo;
    nomeController.text = widget.usuario!.nome;
    senhaController.text = widget.usuario!.senha;
    ativo = widget.usuario!.ativo == 'S' ? true : false;
    administrador = widget.usuario!.administrador == 'S' ? true : false;
    possuiNecessidadeEspeciais =
        widget.usuario!.possuinecessidadesespecial == 'S' ? true : false;
    emailController.text = widget.usuario!.email;
    perfilSelecionado =
        usuarioController.perfisAcesso
            .where((element) => element.codigo == widget.usuario!.codigoPerfil)
            .firstOrNull;
  }

  void validarFormulario(
    String nome,
    String senha,
    bool ativo,
    bool administrador,
    bool possuiNecessidadeEspeciais,
    int codigoPerfilAcesso,
    String email,
  ) async {
    CadastrarUsuarioRequest usuarioDto = CadastrarUsuarioRequest(
      codigo: codigo,
      foto: "",
      nome: nome,
      senha: senha,
      ativo: (ativo ? "S" : "N"),
      administrador: (administrador ? "S" : "N"),
      possuinecessidadesespecial: (possuiNecessidadeEspeciais ? "S" : "N"),
      codigoperfilacesso: perfilSelecionado!.codigo,
      email: email,
    );

    usuarioController.salvarUsuario(usuarioDto);

    if (widget.isEditing) {
      Navigator.pop(context);
    }
  }

  void onSalvarUsuario() {
    final value = usuarioController.salvarUsuarioState.value;

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
        limparFormulario();
      }
    }
  }

  void limparFormulario() {
    nomeController.clear();
    senhaController.clear();
    emailController.clear();
    perfilSelecionado = null;
    ativo = false;
    administrador = false;
    possuiNecessidadeEspeciais = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de Usuario"),
        backgroundColor: Colors.blue,
      ),
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
                    title: const Text("Ativo?"),
                    value: ativo,
                    onChanged: (bool? valor) {
                      setState(() {
                        ativo = valor ?? false;
                      });
                    },
                  ),

                  CheckboxListTile(
                    title: const Text("Será um administrador? "),
                    value: administrador,
                    onChanged: (bool? valor) {
                      setState(() {
                        administrador = valor ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
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
                          onPressed: () {
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            minimumSize: Size(200, 50),
                          ),

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
    usuarioController.salvarUsuarioState.removeListener(onSalvarUsuario);
    super.dispose();
  }
}
