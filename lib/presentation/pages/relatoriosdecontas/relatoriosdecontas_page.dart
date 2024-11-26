import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vjdb/core/widgets/appbar/appbar_widget.dart';
import 'package:vjdb/core/widgets/buttons/option_button_widget.dart';
import 'package:vjdb/presentation/pages/relatoriosdecontas/contasporcliente/selecionar_cliente_page.dart';
import 'package:vjdb/presentation/pages/relatoriosdecontas/contaspordata/selecionar_datas_page.dart';
import 'package:vjdb/presentation/pages/relatoriosdecontas/todascontas/todascontas_page.dart';
import 'package:vjdb/presentation/pages/tabelas/enderecos/enderecos_menu.dart';

class RelatoriosDeContasPage extends StatefulWidget {
  const RelatoriosDeContasPage({super.key});

  @override
  State<RelatoriosDeContasPage> createState() => _RelatoriosDeContastate();
}

class _RelatoriosDeContastate extends State<RelatoriosDeContasPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(titulo: 'RELATÓRIOS'),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          OptionButtonWidget(
              icone: FaIcon(FontAwesomeIcons.fileInvoiceDollar),
              label: 'Todas Contas',
              pagina: TodasContasPage()),
          SizedBox(height: 12),
          OptionButtonWidget(
              icone: FaIcon(FontAwesomeIcons.calendarDay),
              label: 'Contas por Data',
              pagina: SelecionarDatasPage()),
          SizedBox(height: 12),
          OptionButtonWidget(
              icone: FaIcon(FontAwesomeIcons.userLarge),
              label: 'Contas por Cliente',
              pagina: SelecionarClientePage()),
          SizedBox(height: 12),
          OptionButtonWidget(
              icone: FaIcon(FontAwesomeIcons.dollarSign),
              label: 'Contas por Forma de Pagamento',
              pagina: EnderecosMenu()),
          SizedBox(height: 12),
          OptionButtonWidget(
              icone: FaIcon(FontAwesomeIcons.magnifyingGlassDollar),
              label: 'À Receber na Próxima Semana',
              pagina: EnderecosMenu()),
        ]),
      ),
    );
  }
}
