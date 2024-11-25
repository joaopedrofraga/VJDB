import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vjdb/core/widgets/appbar/appbar_widget.dart';
import 'package:vjdb/core/widgets/buttons/option_button_widget.dart';
import 'package:vjdb/presentation/pages/tabelas/clientes/clientes_menu.dart';
import 'package:vjdb/presentation/pages/tabelas/enderecos/enderecos_menu.dart';
import 'package:vjdb/presentation/pages/tabelas/formas/formas_menu.dart';

class TabelasPage extends StatefulWidget {
  const TabelasPage({super.key});

  @override
  State<TabelasPage> createState() => _TabelasPageState();
}

class _TabelasPageState extends State<TabelasPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(titulo: 'TABELAS'),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          OptionButtonWidget(
              icone: FaIcon(FontAwesomeIcons.person),
              label: 'Clientes',
              pagina: ClientesMenu()),
          SizedBox(height: 12),
          OptionButtonWidget(
              icone: FaIcon(FontAwesomeIcons.locationDot),
              label: 'Endereços',
              pagina: EnderecosMenu()),
          SizedBox(height: 12),
          OptionButtonWidget(
              icone: FaIcon(FontAwesomeIcons.moneyBill),
              label: 'Formas de Pagamento',
              pagina: FormasMenu()),
        ]),
      ),
    );
  }
}
