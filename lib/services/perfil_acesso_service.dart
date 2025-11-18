import 'package:login_usuario/model/perfil_acesso.dart';
import 'package:dio/dio.dart';

class PerfilAcessoService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.15.22:51135/api/perfilacesso/",
      headers: {"Content-Type": "application/json"},
    ),
  );

  Future<List<PerfilAcesso>> getPerfisAcesso() async {
    try {
      final response = await _dio.get("obtenhaperfisacesso");
      final List<dynamic> jsonData = response.data['Resultado'];
      return jsonData.map((item) => PerfilAcesso.fromJson(item)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
