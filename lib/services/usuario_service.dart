import 'dart:convert';
import 'package:login_usuario/dto/request/cadastrar_usuario_request.dart';
import 'package:login_usuario/model/usuario.dart';
import 'package:dio/dio.dart';

class UsuarioService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.15.22:51135/api/usuario/",
      headers: {"Content-Type": "application/json"},
    ),
  );

  Future<List<Usuario>> getUserActive() async {
    final response = await _dio.get("obtenhausuariosativos");

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.data)['Resultado'];
      return jsonData.map((item) => Usuario.fromJson(item)).toList();
    } else {
      throw Exception("Erro ao buscar usuarios ativos");
    }
  }

  Future<void> saveUser(CadastrarUsuarioRequest usuarioDto) async {
    try {
      await _dio.post("gravedadosusuario", data: usuarioDto.toJson());
    } on DioException catch (e) {
      if (e.response!.statusCode == 400) {
        List<dynamic> json = e.response?.data["Resultado"];
        throw Exception(json[0]["Message"]);
      }
    }
  }
}
