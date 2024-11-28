import 'package:flutter/material.dart';
import 'package:vjdb/core/config/vjdb_material.dart';
import 'package:vjdb/core/database/conndb.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';
import 'package:vjdb/models/forma_de_pagamento_model.dart';

class FormaListTileWidget extends StatefulWidget {
  final FormaDePagamento formaDePagamento;
  const FormaListTileWidget({super.key, required this.formaDePagamento});

  @override
  State<FormaListTileWidget> createState() => _FormaListTileWidgetState();
}

class _FormaListTileWidgetState extends State<FormaListTileWidget> {
  void desabilitarFormaDePagamento() async {
    final connection = ConnDB();
    connection.open();
    try {
      await connection.query(
          'UPDATE formas_pagamento SET ativo = ? WHERE id = ?',
          [0, widget.formaDePagamento.id]);
    } catch (e) {
      throw Exception(e);
    } finally {
      connection.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: VJDBMaterial.primaryColor,
          child: const Icon(Icons.monetization_on, color: Colors.white),
        ),
        title: TextWidget.bold(widget.formaDePagamento.nome.toUpperCase()),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title:
                  TextWidget.bold('DESEJA DESABILITAR A FORMA DE PAGAMENTO?'),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      try {
                        desabilitarFormaDePagamento();
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: TextWidget.normal(
                                'FORMA DESABILITADA COM SUCESSO!',
                                color: Colors.white),
                            backgroundColor: Colors.green));
                      } catch (e) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: TextWidget.normal('ERRO: $e',
                                color: Colors.white),
                            backgroundColor: Colors.red));
                      }
                    },
                    child: TextWidget.bold('Sim', color: Colors.white)),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () => Navigator.pop(context),
                    child: TextWidget.bold('Não')),
              ],
            ),
          );
        },
      ),
    );
  }
}
