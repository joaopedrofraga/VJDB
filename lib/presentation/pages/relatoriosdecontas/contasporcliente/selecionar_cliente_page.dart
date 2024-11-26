import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vjdb/core/config/vjdb_material.dart';
import 'package:vjdb/core/widgets/appbar/appbar_widget.dart';
import 'package:vjdb/core/widgets/autocomplete/clientes_autocomplete_widget.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';
import 'package:vjdb/models/cliente_model.dart';

class SelecionarClientePage extends StatefulWidget {
  const SelecionarClientePage({super.key});

  @override
  State<SelecionarClientePage> createState() => _EnderecosAdicionarState();
}

class _EnderecosAdicionarState extends State<SelecionarClientePage> {
  late Future<List<Cliente>> futureClientes;
  Cliente? clienteSelecionado;

  void atualizarCliente(Cliente novoCliente) {
    setState(() {
      clienteSelecionado = novoCliente;
    });
  }

  @override
  void initState() {
    futureClientes = fetchClientes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titulo: 'INSIRA O CLIENTE'),
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
                return Column(children: [
                  ClientesAutocompleteWidget(
                      clientes: clientes,
                      clienteSelecionado: clienteSelecionado,
                      atualizarCliente: atualizarCliente),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(FontAwesomeIcons.locationCrosshairs,
                                color: VJDBMaterial.primaryColor),
                            const SizedBox(width: 10),
                            TextWidget.bold('CONSULTAR CONTAS')
                          ]),
                      onPressed: () {},
                    ),
                  )
                ]);
              }
            }),
      ),
    );
  }
}
