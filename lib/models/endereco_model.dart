import 'package:vjdb/core/database/conndb.dart';
import 'package:vjdb/models/cliente_model.dart';

class Endereco {
  final int id;
  final Cliente cliente;
  final String cidade;
  final String bairro;
  final String rua;
  final String numero;
  final String complemento;

  Endereco({
    required this.id,
    required this.cliente,
    required this.cidade,
    required this.bairro,
    required this.rua,
    required this.numero,
    required this.complemento,
  });

  factory Endereco.fromMap(Map<String, dynamic> map) {
    Cliente cliente = Cliente(
        id: map['cliente_id'],
        nome: map['cliente_nome'],
        telefone: map['cliente_telefone'],
        cpfCnpj: map['cliente_cpf_cnpj'],
        ieRg: map['cliente_ie_rg']);

    return Endereco(
        id: map['id'],
        cliente: cliente,
        cidade: map['cidade'],
        bairro: map['bairro'],
        rua: map['rua'],
        numero: map['numero'],
        complemento: map['complemento']);
  }
}

Future<List<Endereco>> fetchEnderecos() async {
  final connection = ConnDB();
  try {
    final results = await connection.query('''
    SELECT
	 e.id,
	 cli.id AS cliente_id,
    cli.nome AS cliente_nome,
    cli.telefone AS cliente_telefone,
    cli.cpf_cnpj AS cliente_cpf_cnpj,
    cli.ie_rg AS cliente_ie_rg,
    e.cidade,
    e.bairro,
    e.rua,
    e.numero,
    e.complemento
FROM enderecos e
JOIN clientes cli ON e.id_cliente = cli.id;
''');
    return results.map((result) {
      return Endereco.fromMap(result.fields);
    }).toList();
  } catch (e) {
    throw Exception(e);
  } finally {
    connection.close();
  }
}
