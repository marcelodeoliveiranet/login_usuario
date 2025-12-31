import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  final String? foto;
  final int codigo;
  final String nome;
  final String administrador;
  final String ativo;
  final String senha;
  final String email;
  final int codigoPerfilAcesso;

  const Usuario({
    required this.foto,
    required this.codigo,
    required this.nome,
    required this.administrador,
    required this.ativo,
    required this.senha,
    required this.email,
    required this.codigoPerfilAcesso,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Foto': foto,
      'Codigo': codigo,
      'Nome': nome,
      'Administrador': administrador,
      'Ativo': ativo,
      'Senha': senha,
      'Email': email,
      'CodigoPerfilAcesso': codigoPerfilAcesso,
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> map) {
    return Usuario(
      foto: map['Foto'] as String,
      codigo: map['Codigo'] as int,
      nome: map['Nome'] as String,
      administrador: map['Administrador'] as String,
      ativo: map['Ativo'] as String,
      senha: map['Senha'] as String,
      email: map['Email'] as String,
      codigoPerfilAcesso: map['CodigoPerfilAcesso'] as int,
    );
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      foto: map['Foto'],
      codigo: map['Codigo'] as int,
      nome: map['Nome'] as String,
      administrador: map['Administrador'] as String,
      ativo: map['Ativo'] as String,
      senha: map['Senha'] as String,
      email: map['Email'] as String,
      codigoPerfilAcesso: map['CodigoPerfilAcesso'] as int,
    );
  }

  @override
  List<Object> get props {
    return [
      codigo,
      nome,
      administrador,
      ativo,
      senha,
      email,
      codigoPerfilAcesso,
    ];
  }
}
