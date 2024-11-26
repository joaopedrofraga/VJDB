import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vjdb/core/config/vjdb_material.dart';
import 'package:vjdb/core/database/conndb.dart';
import 'package:vjdb/core/widgets/appbar/appbar_widget.dart';
import 'package:vjdb/core/widgets/inputs/masked_text_form_field_widget.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';

class SelecionarDatasPage extends StatefulWidget {
  const SelecionarDatasPage({super.key});

  @override
  State<SelecionarDatasPage> createState() => _RelatoriosDeContastate();
}

class _RelatoriosDeContastate extends State<SelecionarDatasPage> {
  MaskedTextController dataInicialTEC =
      MaskedTextController(mask: '00/00/0000');
  MaskedTextController dataFinalTEC = MaskedTextController(mask: '00/00/0000');

  String getDataFormatada(MaskedTextController controller) {
    List<String> data = controller.text.split('/');
    return '${data[2]}-${data[1]}-${data[0]}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titulo: 'INSIRA AS DATAS A SEREM BUSCADAS'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          MaskedTextFormFieldWidget(
              controller: dataInicialTEC, inputLabel: 'DATA INICIAL'),
          const SizedBox(height: 12),
          MaskedTextFormFieldWidget(
              controller: dataFinalTEC, inputLabel: 'DATA FINAL'),
          const SizedBox(height: 12),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                FaIcon(FontAwesomeIcons.calendarCheck,
                    color: VJDBMaterial.primaryColor),
                const SizedBox(width: 10),
                TextWidget.bold('CONSULTAR CONTAS')
              ]),
              onPressed: () async {
                final connection = ConnDB();
                try {
                  await connection.open();
                  await connection.query(
                      'SELECT * FROM contas WHERE vencimento BETWEEN ? AND ?', [
                    getDataFormatada(dataInicialTEC),
                    getDataFormatada(dataFinalTEC)
                  ]);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: TextWidget.normal('CONSULTA FEITA COM SUCESSO!',
                          color: Colors.white),
                      backgroundColor: Colors.green));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          TextWidget.normal('ERRO: $e', color: Colors.white),
                      backgroundColor: Colors.red));
                } finally {
                  await connection.close();
                }
              },
            ),
          )
        ]),
      ),
    );
  }
}
