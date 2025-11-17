import 'dart:convert';

import 'package:login_usuario/model/perfil_acesso.dart';
import 'package:http/http.dart' as http;

class PerfilAcessoService {
  static const String baseUrl =
      "http://192.168.15.22:51135/api/perfilacesso/obtenhaperfisacesso";

  Future<List<PerfilAcesso>> getPerfisAcesso() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['Resultado'];
      return jsonData.map((item) => PerfilAcesso.fromJson(item)).toList();
    } else {
      throw Exception("Erro ao buscar perfis de acesso");
    }
  }
}
