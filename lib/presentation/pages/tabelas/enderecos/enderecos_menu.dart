import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vjdb/core/widgets/appbar/appbar_widget.dart';
import 'package:vjdb/core/widgets/buttons/option_button_widget.dart';
import 'package:vjdb/presentation/pages/tabelas/enderecos/enderecos_adicionar.dart';
import 'package:vjdb/presentation/pages/tabelas/enderecos/enderecos_consultar.dart';

class EnderecosMenu extends StatefulWidget {
  const EnderecosMenu({super.key});

  @override
  State<EnderecosMenu> createState() => _EnderecosMenuState();
}

class _EnderecosMenuState extends State<EnderecosMenu> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(titulo: 'ENDEREÇOS'),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          OptionButtonWidget(
              icone: FaIcon(FontAwesomeIcons.locationCrosshairs),
              label: 'Adicionar',
              pagina: EnderecosAdicionar()),
          SizedBox(height: 12),
          OptionButtonWidget(
              icone: FaIcon(FontAwesomeIcons.globe),
              label: 'Consultar',
              pagina: EnderecosConsultar()),
        ]),
      ),
    );
  }
}
