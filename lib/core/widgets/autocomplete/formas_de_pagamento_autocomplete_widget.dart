import 'package:flutter/material.dart';
import 'package:vjdb/core/widgets/inputs/text_form_field_widget.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';
import 'package:vjdb/models/forma_de_pagamento_model.dart';

// ignore: must_be_immutable
class FormasDePagamentoAutocompleteWidget extends StatefulWidget {
  final List<FormaDePagamento> formasDePagamento;
  FormaDePagamento? formaDePagamentoSelecionada;
  final Function(FormaDePagamento) atualizarFormaDePagamento;
  FormasDePagamentoAutocompleteWidget(
      {super.key,
      required this.formasDePagamento,
      required this.formaDePagamentoSelecionada,
      required this.atualizarFormaDePagamento});

  @override
  State<FormasDePagamentoAutocompleteWidget> createState() =>
      _FormasDePagamentoAutocompleteWidgetState();
}

class _FormasDePagamentoAutocompleteWidgetState
    extends State<FormasDePagamentoAutocompleteWidget> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete<FormaDePagamento>(
      optionsBuilder: (textEdittingValue) {
        if (textEdittingValue.text.isEmpty) {
          return const Iterable<FormaDePagamento>.empty();
        }
        return widget.formasDePagamento.where((FormaDePagamento cliente) {
          return cliente.nome.contains(textEdittingValue.text);
        });
      },
      displayStringForOption: (option) => option.nome,
      onSelected: (option) {
        widget.formaDePagamentoSelecionada = option;
        widget.atualizarFormaDePagamento(option);
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) =>
              TextFormFieldWidget(
                  controller: textEditingController,
                  inputLabel: 'FORMA DE PAGAMENTO',
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
                  final FormaDePagamento option = options.elementAt(index);
                  return GestureDetector(
                    onTap: () => onSelected(option),
                    child: ListTile(
                      leading: const Icon(Icons.attach_money),
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
