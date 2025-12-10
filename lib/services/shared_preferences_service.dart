import 'dart:convert';

import 'package:login_usuario/model/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<void> salvarUsuario(Usuario usuario) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(usuario.toMap());
    await sharedPreferences.setString('user', jsonString);
  }

  Future<Usuario?> buscarUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('user');

    if (jsonString == null) return null;

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return Usuario.fromMap(jsonMap);
  }

  Future<void> limpar() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
