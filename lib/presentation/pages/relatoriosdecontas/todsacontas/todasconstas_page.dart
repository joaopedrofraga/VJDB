import 'package:flutter/material.dart';
import 'package:vjdb/core/widgets/appbar/appbar_widget.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';
import 'package:vjdb/models/conta_model.dart';
import 'package:vjdb/presentation/widgets/conta_list_tile_widget.dart';

class TodasContasPage extends StatefulWidget {
  const TodasContasPage({super.key});

  @override
  State<TodasContasPage> createState() => _TodasContasPageState();
}

class _TodasContasPageState extends State<TodasContasPage> {
  late Future<List<Conta>> futureContas;

  @override
  void initState() {
    futureContas = fetchContas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titulo: 'TODAS CONTAS'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
            future: futureContas,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: TextWidget.bold('ERRO: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                    child: TextWidget.bold('Nenhuma conta encontrada.'));
              } else {
                List<Conta> contas = snapshot.data!;
                return ListView.builder(
                  itemCount: contas.length,
                  itemBuilder: (context, index) {
                    final conta = contas[index];
                    return ContaListTileWidget(conta: conta);
                  },
                );
              }
            }),
      ),
    );
  }
}
