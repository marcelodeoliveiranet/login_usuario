// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginRequest {
  final int codigoUsuario;
  final String senha;

  LoginRequest({required this.codigoUsuario, required this.senha});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'codigoUsuario': codigoUsuario, 'senha': senha};
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      codigoUsuario: map['codigoUsuario'] as int,
      senha: map['senha'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromJson(String source) =>
      LoginRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
