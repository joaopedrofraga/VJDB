import 'package:flutter/material.dart';
import 'package:vjdb/core/widgets/appbar/appbar_widget.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';
import 'package:vjdb/models/forma_de_pagamento_model.dart';
import 'package:vjdb/presentation/pages/tabelas/formas/forma_list_tile_widget.dart';

class FormasConsultar extends StatefulWidget {
  const FormasConsultar({super.key});

  @override
  State<FormasConsultar> createState() => _FormasConsultarState();
}

class _FormasConsultarState extends State<FormasConsultar> {
  late Future<List<FormaDePagamento>> futureFormas;

  @override
  void initState() {
    futureFormas = fetchFormasDePagamentos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titulo: 'CONSULTAR'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
            future: futureFormas,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: TextWidget.bold('ERRO: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                    child: TextWidget.bold(
                        'Nenhuma forma de pagamento encontrada.'));
              } else {
                List<FormaDePagamento> formas = snapshot.data!;
                return ListView.builder(
                    itemBuilder: (context, index) {
                      return FormaListTileWidget(
                          formaDePagamento: formas[index]);
                    },
                    itemCount: formas.length);
              }
            }),
      ),
    );
  }
}
