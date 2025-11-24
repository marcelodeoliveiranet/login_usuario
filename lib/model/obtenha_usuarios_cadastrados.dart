import 'package:equatable/equatable.dart';

class Obtenhausuarioscadastrados extends Equatable {
  final int codigo;
  final bool administrador;
  final bool ativo;
  final String nome;
  final String foto;
  final String senha;

  const Obtenhausuarioscadastrados({
    required this.codigo,
    required this.administrador,
    required this.ativo,
    required this.nome,
    required this.foto,
    required this.senha,
  });

  @override
  List<Object?> get props {
    return [codigo, administrador, ativo, nome, foto, senha];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codigo': codigo,
      'administrador': administrador,
      'ativo': ativo,
      'nome': nome,
      'foto': foto,
      'senha': senha,
    };
  }

  factory Obtenhausuarioscadastrados.fromJson(Map<String, dynamic> map) {
    return Obtenhausuarioscadastrados(
      codigo: map['Codigo'] as int,
      administrador: map['Administrador'] as bool,
      ativo: map['Ativo'] as bool,
      nome: map['Nome'] as String,
      foto: map['Foto'] as String,
      senha: map['Senha'] as String,
    );
  }
}
