import 'package:flutter/material.dart';

class Imc {
  final String _id = UniqueKey().toString();
  String _nome = "";
  double _altura = 0;
  String _resultado = "";

  Imc(this._nome, this._altura, this._resultado);

  String getId() {
    return _id;
  }

  String getNome() {
    return _nome;
  }

  String getResultado() {
    return _resultado;
  }

  void setNome(String nome) {
    _nome = nome;
  }

  double getAltura() {
    return _altura;
  }

  void setAltura(double altura) {
    _altura = altura;
  }

  void setResultado(String resultado) {
    _resultado = resultado;
  }
}
