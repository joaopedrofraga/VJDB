import 'package:flutter/material.dart';
import 'package:vjdb/core/config/vjdb_material.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';
import 'package:vjdb/models/cliente_model.dart';

class ClienteListTileWidget extends StatefulWidget {
  final Cliente cliente;
  const ClienteListTileWidget({super.key, required this.cliente});

  @override
  State<ClienteListTileWidget> createState() => _ClienteListTileWidgetState();
}

class _ClienteListTileWidgetState extends State<ClienteListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: VJDBMaterial.primaryColor,
          child: const Icon(Icons.person, color: Colors.white),
        ),
        title: TextWidget.bold(widget.cliente.nome.toUpperCase()),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget.normal('Telefone: ${widget.cliente.telefone}'),
          ],
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: TextWidget.title('DETALHES DO CLIENTE'),
              content: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Divider(),
                TextWidget.bold('Nome: ${widget.cliente.nome.toUpperCase()}'),
                TextWidget.normal('Telefone: ${widget.cliente.telefone}'),
                TextWidget.normal('CPF/CNPJ: ${widget.cliente.cpfCnpj}'),
                TextWidget.normal('IE/RG: ${widget.cliente.ieRg}'),
                const Divider(),
              ])),
              actions: [
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
