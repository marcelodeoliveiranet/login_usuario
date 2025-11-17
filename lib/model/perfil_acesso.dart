import 'package:equatable/equatable.dart';

class PerfilAcesso extends Equatable {
  final int codigo;
  final String descricao;

  const PerfilAcesso({required this.codigo, required this.descricao});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'codigo': codigo, 'descricao': descricao};
  }

  factory PerfilAcesso.fromJson(Map<String, dynamic> map) {
    return PerfilAcesso(
      codigo: map['Codigo'] as int,
      descricao: map['Descricao'] as String,
    );
  }

  @override
  List<Object> get props => [codigo, descricao];
}
