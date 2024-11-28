import 'package:flutter/material.dart';
import 'package:vjdb/core/config/vjdb_material.dart';
import 'package:vjdb/core/database/conndb.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';
import 'package:vjdb/models/endereco_model.dart';

class EnderecoListTileWidget extends StatefulWidget {
  final Endereco endereco;
  const EnderecoListTileWidget({super.key, required this.endereco});

  @override
  State<EnderecoListTileWidget> createState() => _EnderecoListTileWidgetState();
}

class _EnderecoListTileWidgetState extends State<EnderecoListTileWidget> {
  void excluirEndereco() async {
    final connection = ConnDB();
    connection.open();
    try {
      await connection
          .query('DELETE FROM enderecos WHERE id = ?', [widget.endereco.id]);
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
          child: const Icon(Icons.pin_drop, color: Colors.white),
        ),
        title: TextWidget.bold(widget.endereco.cliente.nome.toUpperCase()),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget.normal('Cidade: ${widget.endereco.cidade}'),
            TextWidget.normal('Bairro: ${widget.endereco.bairro}'),
          ],
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: TextWidget.title('DETALHES DO ENDEREÇO'),
              content: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Divider(),
                TextWidget.bold(
                    'Cliente: ${widget.endereco.cliente.nome.toUpperCase()}'),
                TextWidget.normal('Cidade: ${widget.endereco.cidade}'),
                TextWidget.normal('Bairro: ${widget.endereco.bairro}'),
                TextWidget.normal('Rua: ${widget.endereco.rua}'),
                TextWidget.normal('Número: ${widget.endereco.numero}'),
                TextWidget.normal(
                    'Complemento: ${widget.endereco.complemento}'),
                const Divider(),
              ])),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      try {
                        excluirEndereco();
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: TextWidget.normal(
                                'ENDEREÇO EXCLUIDO COM SUCESSO!',
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
                    child: TextWidget.bold('Excluir', color: Colors.white)),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () => Navigator.pop(context),
                    child: TextWidget.bold('OK')),
              ],
            ),
          );
        },
      ),
    );
  }
}
