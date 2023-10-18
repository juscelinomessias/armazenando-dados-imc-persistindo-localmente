import 'package:aprimorando_calculadora_de_imc/modelos/Imc.dart';

class ImcRepositorio {
  final List<Imc> _imcs = [];

  Future<void> adicionar(Imc imc) async {
    await Future.delayed(const Duration(seconds: 1));
    _imcs.add(imc);
  }

  Future<List<Imc>> listarImcs() async {
    await Future.delayed(const Duration(seconds: 1));
    return _imcs;
  }
}
