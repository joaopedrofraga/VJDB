import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vjdb/core/widgets/appbar/appbar_widget.dart';
import 'package:vjdb/core/widgets/buttons/option_button_widget.dart';
import 'package:vjdb/presentation/pages/tabelas/clientes/clientes_adicionar.dart';
import 'package:vjdb/presentation/pages/tabelas/clientes/clientes_consultar.dart';

class ClientesMenu extends StatefulWidget {
  const ClientesMenu({super.key});

  @override
  State<ClientesMenu> createState() => _ClientesMenuState();
}

class _ClientesMenuState extends State<ClientesMenu> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(titulo: 'CLIENTES'),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          OptionButtonWidget(
              icone: FaIcon(FontAwesomeIcons.userPlus),
              label: 'Adicionar',
              pagina: ClientesAdicionar()),
          SizedBox(height: 12),
          OptionButtonWidget(
              icone: FaIcon(FontAwesomeIcons.addressBook),
              label: 'Consultar',
              pagina: ClientesConsultar()),
        ]),
      ),
    );
  }
}
