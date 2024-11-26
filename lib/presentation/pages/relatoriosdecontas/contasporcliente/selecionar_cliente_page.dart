import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vjdb/core/config/vjdb_material.dart';
import 'package:vjdb/core/database/conndb.dart';
import 'package:vjdb/core/widgets/appbar/appbar_widget.dart';
import 'package:vjdb/core/widgets/autocomplete/clientes_autocomplete_widget.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';
import 'package:vjdb/models/cliente_model.dart';
import 'package:vjdb/models/conta_model.dart';
import 'package:vjdb/presentation/pages/relatoriosdecontas/contasporcliente/contasporcliente_page.dart';

class SelecionarClientePage extends StatefulWidget {
  const SelecionarClientePage({super.key});

  @override
  State<SelecionarClientePage> createState() => _EnderecosAdicionarState();
}

class _EnderecosAdicionarState extends State<SelecionarClientePage> {
  late Future<List<Cliente>> futureClientes;
  Cliente? clienteSelecionado;

  void atualizarCliente(Cliente novoCliente) {
    setState(() {
      clienteSelecionado = novoCliente;
    });
  }

  @override
  void initState() {
    futureClientes = fetchClientes();
    super.initState();
  }

  Future<List<Conta>> consultarContasPorCliente() async {
    final connection = ConnDB();
    try {
      final results = await connection.query('''SELECT
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
LEFT JOIN formas_pagamento f ON c.id_formapag = f.id WHERE id_cliente = ?''',
          [clienteSelecionado!.id]);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: TextWidget.normal('CONSULTA FEITA COM SUCESSO!',
              color: Colors.white),
          backgroundColor: Colors.green));
      return results.map((result) {
        return Conta.fromMap(result.fields);
      }).toList();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: TextWidget.normal('ERRO: $e', color: Colors.white),
          backgroundColor: Colors.red));
      return List.empty();
    } finally {
      connection.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titulo: 'INSIRA O CLIENTE'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
            future: futureClientes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: TextWidget.bold('ERRO: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                    child: TextWidget.bold('Nenhum cliente encontrado.'));
              } else {
                List<Cliente> clientes = snapshot.data!;
                return Column(children: [
                  ClientesAutocompleteWidget(
                      clientes: clientes,
                      clienteSelecionado: clienteSelecionado,
                      atualizarCliente: atualizarCliente),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(FontAwesomeIcons.locationCrosshairs,
                                color: VJDBMaterial.primaryColor),
                            const SizedBox(width: 10),
                            TextWidget.bold('CONSULTAR CONTAS')
                          ]),
                      onPressed: () async {
                        if (clienteSelecionado != null) {
                          List<Conta> contas =
                              await consultarContasPorCliente();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ContasPorClientePage(
                                contas: contas, cliente: clienteSelecionado!),
                          ));
                        }
                      },
                    ),
                  )
                ]);
              }
            }),
      ),
    );
  }
}
