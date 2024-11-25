import 'package:vjdb/core/database/conndb.dart';
import 'package:vjdb/models/cliente_model.dart';
import 'package:vjdb/models/forma_de_pagamento_model.dart';

class Conta {
  final int id;
  final Cliente cliente;
  final FormaDePagamento? formaDePagamento;
  final double valor;
  final String situacao;
  final DateTime? dataBaixa;
  final DateTime emissao;
  final DateTime vencimento;

  Conta({
    required this.id,
    required this.cliente,
    this.formaDePagamento,
    required this.valor,
    required this.situacao,
    this.dataBaixa,
    required this.emissao,
    required this.vencimento,
  });

  factory Conta.fromMap(Map<String, dynamic> map) {
    Cliente cliente = Cliente(
        id: map['cliente_id'],
        nome: map['cliente_nome'],
        telefone: map['cliente_telefone'],
        cpfCnpj: map['cliente_cpf_cnpj'],
        ieRg: map['cliente_ie_rg']);

    FormaDePagamento formaDePagamento = FormaDePagamento(
        id: map['forma_id'] ?? 0,
        nome: map['forma_nome'] ?? '',
        ativo: map['forma_ativo'] ?? 0);

    return Conta(
        id: map['id'],
        cliente: cliente,
        valor: map['valor'],
        formaDePagamento: formaDePagamento,
        situacao: map['situacao'],
        emissao: map['emissao'],
        dataBaixa: map['data_baixa'],
        vencimento: map['vencimento']);
  }
}

Future<List<Conta>> fetchContas() async {
  final connection = ConnDB();
  try {
    final results = await connection.query('''
    SELECT
	 c.id,
	 cli.id AS cliente_id,
    cli.nome AS cliente_nome,
    cli.telefone AS cliente_telefone,
    cli.cpf_cnpj AS cliente_cpf_cnpj,
    cli.ie_rg AS cliente_ie_rg,
    f.id AS forma_id,
    f.nome AS forma_nome,
    f.ativo AS forma_ativo,
    c.valor,
    c.situacao,
    c.data_baixa,
    c.emissao,
    c.vencimento
FROM contas c
LEFT JOIN clientes cli ON c.id_cliente = cli.id
LEFT JOIN formas_pagamento f ON c.id_formapag = f.id;
''');
    return results.map((result) {
      return Conta.fromMap(result.fields);
    }).toList();
  } catch (e) {
    throw Exception(e);
  } finally {
    connection.close();
  }
}
