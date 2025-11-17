// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  final String foto;
  final int codigo;
  final String nome;
  final bool administrador;
  final bool ativo;
  final String senha;
  final String email;
  final int codigoPerfil;

  const Usuario({
    required this.foto,
    required this.codigo,
    required this.nome,
    required this.administrador,
    required this.ativo,
    required this.senha,
    required this.email,
    required this.codigoPerfil,
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
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> map) {
    return Usuario(
      foto: map['Foto'] as String,
      codigo: map['Codigo'] as int,
      nome: map['Nome'] as String,
      administrador: map['Administrador'] as bool,
      ativo: map['Ativo'] as bool,
      senha: map['Senha'] as String,
      email: map['Email'] as String,
      codigoPerfil: map['CodigoPerfil'] as int,
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
    ];
  }
}
