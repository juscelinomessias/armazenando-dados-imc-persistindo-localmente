import 'package:aprimorando_calculadora_de_imc/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Impede a rotação para paisagem
    DeviceOrientation.portraitDown, // Impede a rotação para paisagem invertida
  ]).then((_) {
    runApp(const MyApp());
  });
}
