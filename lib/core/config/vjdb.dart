import 'package:flutter/material.dart';
import 'package:vjdb/core/config/vjdb_material.dart';
import 'package:vjdb/core/widgets/buttons/option_button_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vjdb/presentation/pages/lancarconta/lancarconta_page.dart';
import 'package:vjdb/presentation/pages/relatoriosdecontas/relatoriosdecontas_page.dart';
import 'package:vjdb/presentation/pages/tabelas/tabelas_page.dart';

class VJDB extends StatefulWidget {
  const VJDB({super.key});

  @override
  State<VJDB> createState() => _VJDBState();
}

class _VJDBState extends State<VJDB> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: VJDBMaterial.title,
      theme: VJDBMaterial.getTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar:
            AppBar(title: SizedBox(height: 50, child: VJDBMaterial.getLogo)),
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            OptionButtonWidget(
                icone: FaIcon(FontAwesomeIcons.coins),
                label: 'Tabelas do Sistema',
                pagina: TabelasPage()),
            SizedBox(height: 12),
            OptionButtonWidget(
                icone: FaIcon(FontAwesomeIcons.sackDollar),
                label: 'Lançar Conta',
                pagina: ContasAReceberPage()),
            SizedBox(height: 12),
            OptionButtonWidget(
                icone: FaIcon(FontAwesomeIcons.book),
                label: 'Relatórios de Contas',
                pagina: RelatoriosDeContasPage()),
          ]),
        ),
      ),
    );
  }
}
