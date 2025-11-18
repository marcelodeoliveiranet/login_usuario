import 'dart:convert';

class CadastrarUsuarioRequest {
  final int codigo;
  final String foto;
  final String nome;
  final String senha;
  final String ativo;
  final String administrador;
  final String possuinecessidadesespecial;
  final int codigoperfilacesso;
  final String email;

  const CadastrarUsuarioRequest({
    required this.codigo,
    required this.foto,
    required this.nome,
    required this.senha,
    required this.ativo,
    required this.administrador,
    required this.possuinecessidadesespecial,
    required this.codigoperfilacesso,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codigo': codigo,
      'foto': foto,
      'nome': nome,
      'senha': senha,
      'ativo': ativo,
      'administrador': administrador,
      'possuinecessidadesespecial': possuinecessidadesespecial,
      'codigoperfilacesso': codigoperfilacesso,
      'email': email,
    };
  }

  factory CadastrarUsuarioRequest.fromMap(Map<String, dynamic> map) {
    return CadastrarUsuarioRequest(
      codigo: map['codigo'] as int,
      foto: map['foto'] as String,
      nome: map['nome'] as String,
      senha: map['senha'] as String,
      ativo: map['ativo'] as String,
      administrador: map['administrador'] as String,
      possuinecessidadesespecial: map['possuinecessidadesespecial'] as String,
      codigoperfilacesso: map['codigoperfilacesso'] as int,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CadastrarUsuarioRequest.fromJson(String source) =>
      CadastrarUsuarioRequest.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
