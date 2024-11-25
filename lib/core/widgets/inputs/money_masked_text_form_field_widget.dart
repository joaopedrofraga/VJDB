import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:vjdb/core/config/vjdb_material.dart';
import 'package:vjdb/core/config/vjdb_text_styles.dart';
import 'package:vjdb/core/widgets/texts/text_widget.dart';

class MoneyMaskedTextFormFieldWidget extends StatefulWidget {
  final MoneyMaskedTextController controller;
  final String inputLabel;
  final FocusNode? focusNode;
  const MoneyMaskedTextFormFieldWidget(
      {super.key,
      required this.controller,
      required this.inputLabel,
      this.focusNode});

  @override
  State<MoneyMaskedTextFormFieldWidget> createState() =>
      _MoneyMaskedTextFormFieldWidgetState();
}

class _MoneyMaskedTextFormFieldWidgetState
    extends State<MoneyMaskedTextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: VJDBTextStyles.getNormalStyle,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          label: TextWidget.bold(widget.inputLabel),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(color: VJDBMaterial.primaryColor))),
    );
  }
}
