import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vjdb/core/config/vjdb_material.dart';
import 'package:vjdb/core/database/conndb.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';

class AdicionarFormaButtonWidget extends StatefulWidget {
  final TextEditingController nomeTEC;
  final Function() limparTecs;
  const AdicionarFormaButtonWidget(
      {super.key, required this.nomeTEC, required this.limparTecs});

  @override
  State<AdicionarFormaButtonWidget> createState() =>
      _AdicionarFormaButtonWidgetState();
}

class _AdicionarFormaButtonWidgetState
    extends State<AdicionarFormaButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FaIcon(FontAwesomeIcons.circleDollarToSlot,
              color: VJDBMaterial.primaryColor),
          const SizedBox(width: 10),
          TextWidget.bold('SALVAR FORMA DE PAGAMENTO')
        ]),
        onPressed: () async {
          final connection = ConnDB();
          try {
            await connection.open();
            await connection
                .query('INSERT INTO formas_pagamento (nome) VALUES (?)', [
              widget.nomeTEC.text,
            ]);
            widget.limparTecs();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: TextWidget.normal(
                    'FORMA DE PAGAMENTO ADICIONADA COM SUCESSO!',
                    color: Colors.white),
                backgroundColor: Colors.green));
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: TextWidget.normal('ERRO: $e', color: Colors.white),
                backgroundColor: Colors.red));
          } finally {
            await connection.close();
          }
        },
      ),
    );
  }
}
