import 'package:vjdb/core/database/conndb.dart';

class FormaDePagamento {
  final int id;
  final String nome;
  final int ativo;

  FormaDePagamento({required this.id, required this.nome, required this.ativo});

  factory FormaDePagamento.fromMap(Map<String, dynamic> map) {
    return FormaDePagamento(
      id: map['id'],
      nome: map['nome'],
      ativo: map['ativo'],
    );
  }
}

Future<List<FormaDePagamento>> fetchFormasDePagamentos() async {
  final connection = ConnDB();
  connection.open();
  try {
    final results = await connection
        .query('SELECT * FROM formas_pagamento WHERE ativo = ?', ['1']);
    return results.map((result) {
      return FormaDePagamento.fromMap(result.fields);
    }).toList();
  } catch (e) {
    throw Exception(e);
  } finally {
    connection.close();
  }
}
