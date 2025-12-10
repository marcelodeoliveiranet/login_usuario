import 'package:equatable/equatable.dart';

class UsuarioCadastrado extends Equatable {
  final String foto;
  final int codigo;
  final String nome;
  final String administrador;
  final String ativo;
  final String senha;
  final String email;
  final int codigoPerfil;
  final String possuinecessidadesespecial;

  const UsuarioCadastrado({
    required this.foto,
    required this.codigo,
    required this.nome,
    required this.administrador,
    required this.ativo,
    required this.senha,
    required this.email,
    required this.codigoPerfil,
    required this.possuinecessidadesespecial,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'foto': foto,
      'codigo': codigo,
      'nome': nome,
      'administrador': administrador,
      'ativo': ativo,
      'senha': senha,
      'email': email,
      'codigoPerfil': codigoPerfil,
      'possuinecessidadesespecial': possuinecessidadesespecial,
    };
  }

  factory UsuarioCadastrado.fromJson(Map<String, dynamic> map) {
    return UsuarioCadastrado(
      foto: map['Foto'] as String,
      codigo: map['Codigo'] as int,
      nome: map['Nome'] as String,
      administrador: map['Administrador'] as String,
      ativo: map['Ativo'] as String,
      senha: map['Senha'] as String,
      email: map['Email'] as String,
      codigoPerfil: map['CodigoPerfilAcesso'] as int,
      possuinecessidadesespecial: map['PossuiNecessidadesEspecial'] as String,
    );
  }

  @override
  List<Object> get props {
    return [
      foto,
      codigo,
      nome,
      administrador,
      ativo,
      senha,
      email,
      codigoPerfil,
      possuinecessidadesespecial,
    ];
  }
}
