import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vjdb/core/config/vjdb_material.dart';
import 'package:vjdb/core/database/conndb.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';

class AdicionarClienteButtonWidget extends StatefulWidget {
  final TextEditingController nomeTEC;
  final TextEditingController cpfcnpjTEC;
  final TextEditingController iergTEC;
  final TextEditingController telefoneTEC;
  final Function() limparTecs;
  const AdicionarClienteButtonWidget(
      {super.key,
      required this.nomeTEC,
      required this.cpfcnpjTEC,
      required this.iergTEC,
      required this.telefoneTEC,
      required this.limparTecs});

  @override
  State<AdicionarClienteButtonWidget> createState() =>
      _AdicionarClienteButtonWidgetState();
}

class _AdicionarClienteButtonWidgetState
    extends State<AdicionarClienteButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FaIcon(FontAwesomeIcons.userPlus, color: VJDBMaterial.primaryColor),
          const SizedBox(width: 10),
          TextWidget.bold('SALVAR CLIENTE')
        ]),
        onPressed: () async {
          final connection = ConnDB();
          try {
            await connection.open();
            await connection.query(
                'INSERT INTO clientes (nome, telefone, cpf_cnpj, ie_rg) VALUES (?, ?, ?, ?)',
                [
                  widget.nomeTEC.text,
                  widget.telefoneTEC.text,
                  widget.cpfcnpjTEC.text,
                  widget.iergTEC.text
                ]);
            widget.limparTecs();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: TextWidget.normal('CLIENTE ADICIONADO COM SUCESSO!',
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
