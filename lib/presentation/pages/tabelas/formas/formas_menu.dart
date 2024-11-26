import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vjdb/core/widgets/appbar/appbar_widget.dart';
import 'package:vjdb/core/widgets/buttons/option_button_widget.dart';
import 'package:vjdb/presentation/pages/tabelas/clientes/clientes_consultar.dart';
import 'package:vjdb/presentation/pages/tabelas/formas/formas_adicionar.dart';

class FormasMenu extends StatefulWidget {
  const FormasMenu({super.key});

  @override
  State<FormasMenu> createState() => _FormasMenuState();
}

class _FormasMenuState extends State<FormasMenu> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(titulo: 'FORMAS DE PAGAMENTO'),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          OptionButtonWidget(
              icone: FaIcon(FontAwesomeIcons.circleDollarToSlot),
              label: 'Adicionar',
              pagina: FormasAdicionar()),
          SizedBox(height: 12),
          OptionButtonWidget(
              icone: FaIcon(FontAwesomeIcons.magnifyingGlassDollar),
              label: 'Consultar',
              pagina: ClientesConsultar()),
        ]),
      ),
    );
  }
}
