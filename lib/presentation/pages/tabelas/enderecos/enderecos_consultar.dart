import 'package:flutter/material.dart';
import 'package:vjdb/core/widgets/appbar/appbar_widget.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';
import 'package:vjdb/models/endereco_model.dart';
import 'package:vjdb/presentation/pages/tabelas/enderecos/endereco_list_tile_widget.dart';

class EnderecosConsultar extends StatefulWidget {
  const EnderecosConsultar({super.key});

  @override
  State<EnderecosConsultar> createState() => _EnderecosConsultarState();
}

class _EnderecosConsultarState extends State<EnderecosConsultar> {
  late Future<List<Endereco>> futureEnderecos;

  @override
  void initState() {
    futureEnderecos = fetchEnderecos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titulo: 'CONSULTAR'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
            future: futureEnderecos,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: TextWidget.bold('ERRO: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                    child: TextWidget.bold('Nenhum endereço encontrado.'));
              } else {
                List<Endereco> enderecos = snapshot.data!;
                return ListView.builder(
                    itemBuilder: (context, index) {
                      return EnderecoListTileWidget(endereco: enderecos[index]);
                    },
                    itemCount: enderecos.length);
              }
            }),
      ),
    );
  }
}
