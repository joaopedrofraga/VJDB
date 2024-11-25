import 'package:flutter/material.dart';
import 'package:vjdb/core/widgets/inputs/text_form_field_widget.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';
import 'package:vjdb/models/cliente_model.dart';

// ignore: must_be_immutable
class ClientesAutocompleteWidget extends StatefulWidget {
  final List<Cliente> clientes;
  Cliente? clienteSelecionado;
  final Function(Cliente) atualizarCliente;
  ClientesAutocompleteWidget(
      {super.key,
      required this.clientes,
      required this.clienteSelecionado,
      required this.atualizarCliente});

  @override
  State<ClientesAutocompleteWidget> createState() =>
      _ClientesAutocompleteWidgetState();
}

class _ClientesAutocompleteWidgetState
    extends State<ClientesAutocompleteWidget> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete<Cliente>(
      optionsBuilder: (textEdittingValue) {
        if (textEdittingValue.text.isEmpty) {
          return const Iterable<Cliente>.empty();
        }
        return widget.clientes.where((Cliente cliente) {
          return cliente.nome.contains(textEdittingValue.text);
        });
      },
      displayStringForOption: (option) => option.nome,
      onSelected: (option) {
        widget.clienteSelecionado = option;
        widget.atualizarCliente(option);
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) =>
              TextFormFieldWidget(
                  controller: textEditingController,
                  inputLabel: 'CLIENTE',
                  focusNode: focusNode),
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500, maxHeight: 200),
              child: ListView.builder(
                padding: const EdgeInsets.all(4),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final Cliente option = options.elementAt(index);
                  return GestureDetector(
                    onTap: () => onSelected(option),
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: TextWidget.normal(option.nome),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
