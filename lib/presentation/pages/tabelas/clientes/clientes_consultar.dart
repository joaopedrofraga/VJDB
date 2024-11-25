import 'package:flutter/material.dart';
import 'package:vjdb/core/widgets/appbar/appbar_widget.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';
import 'package:vjdb/models/cliente_model.dart';

class ClientesConsultar extends StatefulWidget {
  const ClientesConsultar({super.key});

  @override
  State<ClientesConsultar> createState() => _ClientesConsultarState();
}

class _ClientesConsultarState extends State<ClientesConsultar> {
  late Future<List<Cliente>> futureClientes;

  @override
  void initState() {
    futureClientes = fetchClientes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titulo: 'CONSULTAR'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
            future: futureClientes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: TextWidget.bold('ERRO: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                    child: TextWidget.bold('Nenhum cliente encontrado.'));
              } else {
                List<Cliente> clientes = snapshot.data!;
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return TextWidget.normal(clientes[index].nome);
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(height: 0.2);
                    },
                    itemCount: clientes.length);
              }
            }),
      ),
    );
  }
}
