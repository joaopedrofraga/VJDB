import 'package:vjdb/core/database/conndb.dart';

class Cliente {
  final int id;
  final String nome;
  final String telefone;
  final String cpfCnpj;
  final String ieRg;

  Cliente(
      {required this.id,
      required this.nome,
      required this.telefone,
      required this.cpfCnpj,
      required this.ieRg});

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'],
      nome: map['nome'],
      telefone: map['telefone'],
      cpfCnpj: map['cpf_cnpj'],
      ieRg: map['ie_rg'],
    );
  }
}

Future<List<Cliente>> fetchClientes() async {
  final connection = ConnDB();
  try {
    final results = await connection.query('SELECT * FROM clientes');
    return results.map((result) {
      return Cliente.fromMap(result.fields);
    }).toList();
  } catch (e) {
    throw Exception(e);
  } finally {
    connection.close();
  }
}
