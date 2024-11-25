import 'package:flutter/material.dart';
import 'package:vjdb/core/widgets/appbar/appbar_widget.dart';
import 'package:vjdb/core/widgets/autocomplete/clientes_autocomplete_widget.dart';
import 'package:vjdb/core/widgets/buttons/adicionar_endereco_button_widget.dart';
import 'package:vjdb/core/widgets/inputs/text_form_field_widget.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';
import 'package:vjdb/models/cliente_model.dart';

class EnderecosAdicionar extends StatefulWidget {
  const EnderecosAdicionar({super.key});

  @override
  State<EnderecosAdicionar> createState() => _EnderecosAdicionarState();
}

class _EnderecosAdicionarState extends State<EnderecosAdicionar> {
  late Future<List<Cliente>> futureClientes;
  TextEditingController cidadeTEC = TextEditingController();
  TextEditingController bairroTEC = TextEditingController();
  TextEditingController ruaTEC = TextEditingController();
  TextEditingController numeroTEC = TextEditingController();
  TextEditingController complementoTEC = TextEditingController();
  Cliente? clienteSelecionado;

  void limparTECs() {
    setState(() {
      cidadeTEC.clear();
      bairroTEC.clear();
      ruaTEC.clear();
      numeroTEC.clear();
      complementoTEC.clear();
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
      appBar: const AppBarWidget(titulo: 'ADICIONAR'),
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
                  TextFormFieldWidget(
                      controller: cidadeTEC, inputLabel: 'CIDADE'),
                  const SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                      child: TextFormFieldWidget(
                          controller: bairroTEC, inputLabel: 'BAIRRO'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: TextFormFieldWidget(
                            controller: ruaTEC, inputLabel: 'RUA')),
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                      child: TextFormFieldWidget(
                          controller: numeroTEC, inputLabel: 'NÚMERO'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormFieldWidget(
                          controller: complementoTEC,
                          inputLabel: 'COMPLEMENTO'),
                    ),
                  ]),
                  const SizedBox(height: 10),
                  AdicionarEnderecoButtonWidget(
                      limparTecs: limparTECs,
                      cliente: clienteSelecionado,
                      cidadeTEC: cidadeTEC,
                      bairroTEC: bairroTEC,
                      ruaTEC: ruaTEC,
                      numeroTEC: numeroTEC,
                      complementoTEC: complementoTEC),
                ]);
              }
            }),
      ),
    );
  }
}
