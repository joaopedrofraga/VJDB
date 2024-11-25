import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';

class OptionButtonWidget extends StatefulWidget {
  final FaIcon icone;
  final String label;
  final Widget pagina;
  const OptionButtonWidget(
      {super.key,
      required this.icone,
      required this.label,
      required this.pagina});

  @override
  State<OptionButtonWidget> createState() => _OptionButtonWidgetState();
}

class _OptionButtonWidgetState extends State<OptionButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          widget.icone,
          const SizedBox(width: 10),
          TextWidget.bold(widget.label.toUpperCase())
        ]),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => widget.pagina,
            ),
          );
        },
      ),
    );
  }
}
