import 'package:flutter/material.dart';
import 'package:vjdb/core/widgets/appbar/appbar_widget.dart';
import 'package:vjdb/models/conta_model.dart';
import 'package:vjdb/presentation/widgets/conta_list_tile_widget.dart';

class ContasPorDataPage extends StatefulWidget {
  final List<Conta> contas;
  final String dataInicial;
  final String dataFinal;
  const ContasPorDataPage(
      {super.key,
      required this.contas,
      required this.dataInicial,
      required this.dataFinal});

  @override
  State<ContasPorDataPage> createState() => _ContasPorDataPageState();
}

class _ContasPorDataPageState extends State<ContasPorDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          titulo: 'CONTAS (${widget.dataInicial} - ${widget.dataFinal})'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: widget.contas.length,
          itemBuilder: (context, index) {
            final conta = widget.contas[index];
            return ContaListTileWidget(conta: conta, atualizarPagina: () {});
          },
        ),
      ),
    );
  }
}
