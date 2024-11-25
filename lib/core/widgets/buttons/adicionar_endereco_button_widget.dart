import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vjdb/core/config/vjdb_material.dart';
import 'package:vjdb/core/database/conndb.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';
import 'package:vjdb/models/cliente_model.dart';

class AdicionarEnderecoButtonWidget extends StatefulWidget {
  final Cliente? cliente;
  final TextEditingController cidadeTEC;
  final TextEditingController bairroTEC;
  final TextEditingController ruaTEC;
  final TextEditingController numeroTEC;
  final TextEditingController complementoTEC;

  final Function() limparTecs;
  const AdicionarEnderecoButtonWidget(
      {super.key,
      required this.limparTecs,
      required this.cliente,
      required this.cidadeTEC,
      required this.bairroTEC,
      required this.ruaTEC,
      required this.numeroTEC,
      required this.complementoTEC,
      atualizarCliente});

  @override
  State<AdicionarEnderecoButtonWidget> createState() =>
      _AdicionarEnderecoButtonWidgetState();
}

class _AdicionarEnderecoButtonWidgetState
    extends State<AdicionarEnderecoButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FaIcon(FontAwesomeIcons.locationCrosshairs,
              color: VJDBMaterial.primaryColor),
          const SizedBox(width: 10),
          TextWidget.bold('SALVAR ENDEREÇO')
        ]),
        onPressed: () async {
          final connection = ConnDB();
          try {
            await connection.open();
            await connection.query(
                'INSERT INTO enderecos (id_cliente, cidade, bairro, rua, numero, complemento) VALUES (?, ?, ?, ?, ?, ?)',
                [
                  widget.cliente!.id,
                  widget.cidadeTEC.text,
                  widget.bairroTEC.text,
                  widget.ruaTEC.text,
                  widget.numeroTEC.text,
                  widget.complementoTEC.text,
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
