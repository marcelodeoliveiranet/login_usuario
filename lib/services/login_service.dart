import 'package:dio/dio.dart';
import 'package:login_usuario/dto/request/login_request.dart';
import 'package:login_usuario/model/usuario.dart';

class LoginService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.15.22:51135/api/usuario/",
      headers: {"Content-Type": "application/json"},
    ),
  );

  Future<Usuario> login(LoginRequest dadosLogin) async {
    try {
      final response = await _dio.post("login", data: dadosLogin.toJson());
      print(response);
      return Usuario.fromMap(response.data["Resultado"]);
    } on DioException catch (e) {
      if (e.response!.statusCode == 400) {
        print(e);
        List<dynamic> json = e.response?.data["Resultado"];
        throw Exception(json[0]["Message"]);
      }
      rethrow;
    }
  }
}
