import 'package:flutter/material.dart';
import 'package:vjdb/core/database/conndb.dart';
import 'package:vjdb/core/widgets/appbar/appbar_widget.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';
import 'package:vjdb/models/conta_model.dart';
import 'package:vjdb/presentation/widgets/conta_list_tile_widget.dart';

class AReceberNaProximaSemanaPage extends StatefulWidget {
  const AReceberNaProximaSemanaPage({super.key});

  @override
  State<AReceberNaProximaSemanaPage> createState() =>
      _AReceberNaProximaSemanaPageState();
}

class _AReceberNaProximaSemanaPageState
    extends State<AReceberNaProximaSemanaPage> {
  late Future<List<Conta>> futureContas;

  @override
  void initState() {
    futureContas = consultarContasDaProximaSemana();
    super.initState();
  }

  void atualizarPagina() {
    setState(() {
      futureContas = consultarContasDaProximaSemana();
    });
  }

  String retornaDataFormatada(DateTime data) {
    return '${data.year}-${data.month}-${data.day}';
  }

  Future<List<Conta>> consultarContasDaProximaSemana() async {
    final connection = ConnDB();
    String diaAtual = retornaDataFormatada(DateTime.now());
    String diaFinal =
        retornaDataFormatada(DateTime.now().add(const Duration(days: 7)));
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
LEFT JOIN formas_pagamento f ON c.id_formapag = f.id
WHERE situacao = ? AND vencimento BETWEEN ? AND ?;
''', ['A', diaAtual, diaFinal]);
      return results.map((result) {
        return Conta.fromMap(result.fields);
      }).toList();
    } catch (e) {
      throw Exception(e);
    } finally {
      connection.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titulo: 'TODAS CONTAS'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
            future: futureContas,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: TextWidget.bold('ERRO: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                    child: TextWidget.bold('Nenhuma conta encontrada.'));
              } else {
                List<Conta> contas = snapshot.data!;
                return ListView.builder(
                  itemCount: contas.length,
                  itemBuilder: (context, index) {
                    final conta = contas[index];
                    return ContaListTileWidget(
                        conta: conta, atualizarPagina: atualizarPagina);
                  },
                );
              }
            }),
      ),
    );
  }
}
