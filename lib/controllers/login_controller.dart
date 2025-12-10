// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:login_usuario/dto/request/login_request.dart';
import 'package:login_usuario/model/usuario.dart';
import 'package:login_usuario/services/login_service.dart';
import 'package:login_usuario/services/shared_preferences_service.dart';

class LoginController extends ChangeNotifier {
  final SharedPreferencesService sharedPreferences;
  final LoginService loginService;
  Usuario? usuarioLogado;

  LoginController({
    required this.sharedPreferences,
    required this.loginService,
  });

  Future<void> verficarUsuarioLogado() async {
    try {
      usuarioLogado = await sharedPreferences.buscarUsuario();
    } finally {
      notifyListeners();
    }
  }

  Future<void> logarUsuario(LoginRequest loginRequest) async {
    try {
      final usuario = await loginService.login(loginRequest);

      usuarioLogado = usuario;
      await sharedPreferences.salvarUsuario(usuario);
    } catch (e) {
    } finally {
      notifyListeners();
    }
  }

  Future<void> logOut() async {
    try {
      await sharedPreferences.limpar();
      usuarioLogado = null;
    } catch (e) {
    } finally {
      notifyListeners();
    }
  }
}
