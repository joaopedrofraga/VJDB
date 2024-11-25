import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;
  const AppBarWidget({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextWidget.title(titulo, color: Colors.white),
      leading: IconButton(
        icon: const FaIcon(FontAwesomeIcons.angleLeft, color: Colors.white),
        onPressed: () => Navigator.pop(context),
        tooltip: 'Voltar',
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
