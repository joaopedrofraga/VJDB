import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vjdb/core/config/vjdb_material.dart';
import 'package:vjdb/core/database/conndb.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';
import 'package:vjdb/models/cliente_model.dart';

class AdicionarContaButtonWidget extends StatefulWidget {
  final Cliente? cliente;
  final TextEditingController valorTEC;
  final TextEditingController dataTEC;

  final Function() limparTecs;
  const AdicionarContaButtonWidget(
      {super.key,
      required this.limparTecs,
      required this.cliente,
      required this.valorTEC,
      required this.dataTEC,
      atualizarCliente});

  @override
  State<AdicionarContaButtonWidget> createState() =>
      _AdicionarContaButtonWidgetState();
}

String valorFormatado(TextEditingController valor) {
  return valor.text.substring(3).replaceAll('.', '').replaceAll(',', '.');
}

String dataFormatada(TextEditingController data) {
  String dia = data.text.substring(0, 2);
  String mes = data.text.substring(3, 5);
  String ano = data.text.substring(6, 10);
  return '$ano-$mes-$dia';
}

String dataFormatadaHoje() {
  DateTime hoje = DateTime.now();
  return '${hoje.year}-${hoje.month}-${hoje.day}';
}

class _AdicionarContaButtonWidgetState
    extends State<AdicionarContaButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FaIcon(FontAwesomeIcons.cashRegister,
              color: VJDBMaterial.primaryColor),
          const SizedBox(width: 10),
          TextWidget.bold('LANÇAR CONTA')
        ]),
        onPressed: () async {
          final connection = ConnDB();
          try {
            await connection.open();
            await connection.query(
                'INSERT INTO contas (id_cliente, valor, situacao, emissao, vencimento) VALUES (?, ?, ?, ?, ?)',
                [
                  widget.cliente!.id,
                  valorFormatado(widget.valorTEC),
                  'A',
                  dataFormatadaHoje(),
                  dataFormatada(widget.dataTEC),
                ]);
            widget.limparTecs();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: TextWidget.normal('ENDEREÇO ADICIONADO COM SUCESSO!',
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
