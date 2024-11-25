import 'dart:io';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:vjdb/core/config/vjdb.dart';
import 'package:vjdb/core/database/conndb.dart';

void main() {
  getConfigBancoDeDados();
  runApp(const VJDB());
  doWhenWindowReady(() {
    const size = Size(600, 450);
    appWindow.title = 'Feito por João Fraga e Vinicius Coelho.';
    appWindow.maxSize = size;
    appWindow.minSize = size;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

void getConfigBancoDeDados() async {
  String conteudo = await File('config.ini').readAsString();
  List<String> configs = conteudo.split(';');
  ConnDB().host = configs[0].substring(5);
  ConnDB().port = int.parse(configs[1].substring(5));
  ConnDB().user = configs[2].substring(5);
  ConnDB().password = configs[3].substring(5);
  ConnDB().database = configs[4].substring(3);
}
