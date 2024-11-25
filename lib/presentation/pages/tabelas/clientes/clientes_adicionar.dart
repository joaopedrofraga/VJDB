import 'package:flutter/material.dart';
import 'package:vjdb/core/widgets/appbar/appbar_widget.dart';
import 'package:vjdb/core/widgets/buttons/adicionar_cliente_button_widget.dart';
import 'package:vjdb/core/widgets/inputs/text_form_field_widget.dart';

class ClientesAdicionar extends StatefulWidget {
  const ClientesAdicionar({super.key});

  @override
  State<ClientesAdicionar> createState() => _ClientesAdicionarState();
}

class _ClientesAdicionarState extends State<ClientesAdicionar> {
  TextEditingController nomeTEC = TextEditingController();
  TextEditingController cpfcnpjTEC = TextEditingController();
  TextEditingController iergTEC = TextEditingController();
  TextEditingController telefoneTEC = TextEditingController();

  void limparTECs() {
    setState(() {
      nomeTEC.clear();
      cpfcnpjTEC.clear();
      iergTEC.clear();
      telefoneTEC.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titulo: 'ADICIONAR'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          TextFormFieldWidget(controller: nomeTEC, inputLabel: 'NOME'),
          const SizedBox(height: 10),
          TextFormFieldWidget(controller: telefoneTEC, inputLabel: 'TELEFONE'),
          const SizedBox(height: 10),
          TextFormFieldWidget(controller: cpfcnpjTEC, inputLabel: 'CPF/CNPJ'),
          const SizedBox(height: 10),
          TextFormFieldWidget(controller: iergTEC, inputLabel: 'IE/RG'),
          const SizedBox(height: 10),
          AdicionarClienteButtonWidget(
              nomeTEC: nomeTEC,
              cpfcnpjTEC: cpfcnpjTEC,
              iergTEC: iergTEC,
              telefoneTEC: telefoneTEC,
              limparTecs: limparTECs)
        ]),
      ),
    );
  }
}
