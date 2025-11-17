import 'package:flutter/material.dart';
import 'package:login_usuario/model/perfil_acesso.dart';
import 'package:login_usuario/services/perfil_acesso_service.dart';

class UsuarioController extends ChangeNotifier {
  List<PerfilAcesso> perfisAcesso = [];
  PerfilAcessoService perfilAcessoService = PerfilAcessoService();

  Future<void> buscarPerfilAcesso() async {
    try {
      perfisAcesso = await perfilAcessoService.getPerfisAcesso();
    } catch (e) {
    } finally {
      notifyListeners();
    }
  }
}
