import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:vjdb/core/widgets/appbar/appbar_widget.dart';
import 'package:vjdb/core/widgets/autocomplete/clientes_autocomplete_widget.dart';
import 'package:vjdb/core/widgets/buttons/adicionar_conta_button_widget.dart';
import 'package:vjdb/core/widgets/inputs/masked_text_form_field_widget.dart';
import 'package:vjdb/core/widgets/inputs/money_masked_text_form_field_widget.dart';
import 'package:vjdb/core/widgets/inputs/text_form_field_widget.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';
import 'package:vjdb/models/cliente_model.dart';

class ContasAReceberPage extends StatefulWidget {
  const ContasAReceberPage({super.key});

  @override
  State<ContasAReceberPage> createState() => _ContasAReceberPageState();
}

class _ContasAReceberPageState extends State<ContasAReceberPage> {
  late Future<List<Cliente>> futureClientes;
  MoneyMaskedTextController valorTEC =
      MoneyMaskedTextController(leftSymbol: 'R\$ ');
  MaskedTextController vencimentoTEC = MaskedTextController(mask: '00/00/0000');
  Cliente? clienteSelecionado;

  void limparTECs() {
    setState(() {
      valorTEC.clear();
      vencimentoTEC.clear();
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titulo: 'LANÇAR CONTA'),
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
                  MoneyMaskedTextFormFieldWidget(
                      controller: valorTEC, inputLabel: 'VALOR'),
                  const SizedBox(height: 10),
                  MaskedTextFormFieldWidget(
                      controller: vencimentoTEC, inputLabel: 'VENCIMENTO'),
                  const SizedBox(height: 10),
                  AdicionarContaButtonWidget(
                      limparTecs: limparTECs,
                      cliente: clienteSelecionado,
                      valorTEC: valorTEC,
                      dataTEC: vencimentoTEC)
                ]);
              }
            }),
      ),
    );
  }
}
