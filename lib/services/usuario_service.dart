import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login_usuario/dto/request/cadastrar_usuario_request.dart';
import 'package:login_usuario/model/usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioService {
  static const String baseUrl =
      "http://192.168.15.22:51135/api/usuario/obtenhausuariosativos";

  Future<List<Usuario>> getUserActive() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['Resultado'];
      return jsonData.map((item) => Usuario.fromJson(item)).toList();
    } else {
      throw Exception("Erro ao buscar usuarios ativos");
    }
  }

  Future<void> saveUser(CadastrarUsuarioRequest usuarioDto) async {
    final Uri uri = Uri.parse(
      "http://192.168.15.22:51135/api/usuario/gravedadosusuario",
    );
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: usuarioDto.toJson(),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
    } else {
      debugPrint("Erro:  ${response.statusCode} - ${response.body}");
    }
  }
}
