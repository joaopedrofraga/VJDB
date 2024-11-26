import 'package:flutter/material.dart';
import 'package:vjdb/core/widgets/appbar/appbar_widget.dart';
import 'package:vjdb/models/cliente_model.dart';
import 'package:vjdb/models/conta_model.dart';
import 'package:vjdb/presentation/widgets/conta_list_tile_widget.dart';

class ContasPorClientePage extends StatefulWidget {
  final List<Conta> contas;
  final Cliente cliente;
  const ContasPorClientePage(
      {super.key, required this.contas, required this.cliente});

  @override
  State<ContasPorClientePage> createState() => _ContasPorClientePageState();
}

class _ContasPorClientePageState extends State<ContasPorClientePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          titulo: 'CONTAS DE ${widget.cliente.nome.toUpperCase()}'),
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
