import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vjdb/core/config/vjdb_material.dart';
import 'package:vjdb/core/widgets/autocomplete/formas_de_pagamento_autocomplete_widget.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';
import 'package:vjdb/models/conta_model.dart';
import 'package:vjdb/models/forma_de_pagamento_model.dart';

// ignore: must_be_immutable
class ContaListTileWidget extends StatefulWidget {
  final Conta conta;
  const ContaListTileWidget({super.key, required this.conta});

  @override
  State<ContaListTileWidget> createState() => _ContaListTileWidgetState();
}

class _ContaListTileWidgetState extends State<ContaListTileWidget> {
  List<FormaDePagamento> formasDePagamento = [];
  FormaDePagamento? formaDePagamentoSelecionada;

  String dataFormatada(DateTime data) {
    return '${data.day < 10 ? '0' : ''}${data.day}/${data.month < 10 ? '0' : ''}${data.month}/${data.year}';
  }

  String valorFormatado(double valor) {
    return 'R\$ ${valor.toString().replaceAll('.', ',')}';
  }

  void atualizarFormaDePagamento(FormaDePagamento novaForma) {
    setState(() {
      formaDePagamentoSelecionada = novaForma;
    });
  }

  @override
  void initState() {
    super.initState();
    carregarFormasDePagamento();
  }

  Future<void> carregarFormasDePagamento() async {
    try {
      formasDePagamento = await fetchFormasDePagamentos();
      print(
          'Tamanho da lista de formas de pagamento: ${formasDePagamento.length}');
    } catch (e) {
      print(e);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool paga = widget.conta.situacao == 'B';
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: paga ? Colors.green : Colors.red,
          child: TextWidget.normal(widget.conta.id.toString(),
              color: Colors.white),
        ),
        title: TextWidget.bold(widget.conta.cliente.nome.toUpperCase()),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget.normal('Valor: ${valorFormatado(widget.conta.valor)}'),
            TextWidget.normal(
                'Vencimento: ${dataFormatada(widget.conta.vencimento)}'),
          ],
        ),
        trailing: paga
            ? const FaIcon(FontAwesomeIcons.check)
            : widget.conta.vencimento
                    .isBefore(DateTime.now().add(const Duration(days: -1)))
                ? const FaIcon(FontAwesomeIcons.xmark)
                : const FaIcon(FontAwesomeIcons.envelopeOpen),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: TextWidget.title('DETALHES DA CONTA'),
              content: SingleChildScrollView(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: paga
                          ? [
                              const Divider(),
                              TextWidget.bold('DADOS DO CLIENTE'),
                              TextWidget.normal(
                                  'Nome: ${widget.conta.cliente.nome.toUpperCase()}'),
                              TextWidget.normal(
                                  'Telefone: ${widget.conta.cliente.telefone}'),
                              TextWidget.normal(
                                  'CPF/CNPJ: ${widget.conta.cliente.cpfCnpj}'),
                              TextWidget.normal(
                                  'IE/RG: ${widget.conta.cliente.ieRg}'),
                              const Divider(),
                              TextWidget.bold('DADOS DO PAGAMENTO'),
                              TextWidget.normal('CONTA PAGA'),
                              TextWidget.normal(
                                  'Forma: ${widget.conta.formaDePagamento!.nome}'),
                              TextWidget.normal(
                                  'Valor: ${valorFormatado(widget.conta.valor)}'),
                              TextWidget.normal(
                                  'Vencimento: ${dataFormatada(widget.conta.vencimento)}'),
                              TextWidget.normal(
                                  'Baixa: ${dataFormatada(widget.conta.dataBaixa!)}'),
                              const Divider(),
                            ]
                          : [
                              const Divider(),
                              TextWidget.bold('DADOS DO CLIENTE'),
                              TextWidget.normal(
                                  'Nome: ${widget.conta.cliente.nome.toUpperCase()}'),
                              TextWidget.normal(
                                  'Telefone: ${widget.conta.cliente.telefone}'),
                              TextWidget.normal(
                                  'CPF/CNPJ: ${widget.conta.cliente.cpfCnpj}'),
                              TextWidget.normal(
                                  'IE/RG: ${widget.conta.cliente.ieRg}'),
                              const Divider(),
                              TextWidget.bold('DADOS DO PAGAMENTO'),
                              TextWidget.normal('CONTA ABERTA'),
                              TextWidget.normal(
                                  'Valor: ${valorFormatado(widget.conta.valor)}'),
                              TextWidget.normal(
                                  'Vencimento: ${dataFormatada(widget.conta.vencimento)}'),
                              const Divider(),
                            ])),
              actions: [
                if (!paga)
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: VJDBMaterial.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: () {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: TextWidget.title('BAIXA DE CONTA'),
                                  content: FormasDePagamentoAutocompleteWidget(
                                      formasDePagamento: formasDePagamento,
                                      formaDePagamentoSelecionada:
                                          formaDePagamentoSelecionada,
                                      atualizarFormaDePagamento:
                                          atualizarFormaDePagamento),
                                ));
                      },
                      child: TextWidget.bold('Baixar', color: Colors.white)),
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