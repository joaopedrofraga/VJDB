import 'package:flutter/material.dart';
import 'package:vjdb/core/widgets/appbar/appbar_widget.dart';
import 'package:vjdb/core/widgets/buttons/adicionar_cliente_button_widget.dart';
import 'package:vjdb/core/widgets/buttons/adicionar_forma_button_widget.dart';
import 'package:vjdb/core/widgets/inputs/text_form_field_widget.dart';

class FormasAdicionar extends StatefulWidget {
  const FormasAdicionar({super.key});

  @override
  State<FormasAdicionar> createState() => _FormasAdicionarState();
}

class _FormasAdicionarState extends State<FormasAdicionar> {
  TextEditingController nomeTEC = TextEditingController();

  void limparTECs() {
    setState(() {
      nomeTEC.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titulo: 'ADICIONAR'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          TextFormFieldWidget(controller: nomeTEC, inputLabel: 'DESCRIÇÃO'),
          const SizedBox(height: 10),
          AdicionarFormaButtonWidget(nomeTEC: nomeTEC, limparTecs: limparTECs),
        ]),
      ),
    );
  }
}
