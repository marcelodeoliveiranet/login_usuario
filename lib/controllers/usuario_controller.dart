import 'package:flutter/material.dart';
import 'package:login_usuario/dto/request/cadastrar_usuario_request.dart';
import 'package:login_usuario/model/perfil_acesso.dart';
import 'package:login_usuario/model/usuario.dart';
import 'package:login_usuario/services/perfil_acesso_service.dart';
import 'package:login_usuario/services/usuario_service.dart';
import 'package:login_usuario/states/base_state.dart';

class UsuarioController extends ChangeNotifier {
  List<PerfilAcesso> perfisAcesso = [];
  List<Usuario> usuariosAtivos = [];
  PerfilAcessoService perfilAcessoService = PerfilAcessoService();
  UsuarioService usuarioService = UsuarioService();
  ValueNotifier<BaseState> perfilAcessoState = ValueNotifier(IdleState());
  ValueNotifier<BaseState> salvarUsuarioState = ValueNotifier(IdleState());
  ValueNotifier<BaseState> usuarioState = ValueNotifier(IdleState());

  Future<void> buscarPerfilAcesso() async {
    perfilAcessoState.value = LoadingState();

    try {
      perfisAcesso = await perfilAcessoService.getPerfisAcesso();
      perfilAcessoState.value = SuccessState(
        sucesso: "Perfil de acesso carregado",
      );
    } catch (e) {
      perfilAcessoState.value = ErrorState(erro: e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> obtenhaUsuariosAtivos() async {
    usuarioState.value = LoadingState();

    try {
      usuariosAtivos = await usuarioService.obtenhaUsuariosAtivos();
      usuarioState.value = SuccessState(sucesso: "Usuarios ativos carregados");
    } catch (e) {
      usuarioState.value = ErrorState(erro: e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> salvarUsuario(CadastrarUsuarioRequest usuarioDto) async {
    salvarUsuarioState.value = LoadingState();

    try {
      await usuarioService.saveUser(usuarioDto);
      await Future.delayed(Duration(seconds: 1));
      salvarUsuarioState.value = SuccessState(
        sucesso: "Usuario gravado com sucesso",
      );
    } catch (e) {
      salvarUsuarioState.value = ErrorState(erro: e.toString());
    } finally {
      notifyListeners();
    }
  }
}
