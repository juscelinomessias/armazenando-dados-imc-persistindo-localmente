import 'package:aprimorando_calculadora_de_imc/helper/DatabaseHelper.dart';
import 'package:aprimorando_calculadora_de_imc/modelos/Imc.dart';

class ImcDAO {
  // acessar banco de dados
  DatabaseHelper _db = DatabaseHelper();
  static final String nomeTabela = "imcs";

  // salvar informações no banco de dados
  Future<dynamic> salvarImc(Imc imc) async {
    var bancoDados = await _db.db;
    dynamic resultado = await bancoDados.insert(nomeTabela, imc.toMap());
    return resultado;
  }

  // recuperar informações no banco de dados
  recuperarImc() async {
    var bancoDados = await _db.db;
    String sql = "SELECT * FROM $nomeTabela ORDER BY nome ASC";
    List imc = await bancoDados.rawQuery(sql);
    return imc;
  }

  // recuperar informações no banco de dados
  recuperarUmImc(dynamic id) async {
    var bancoDados = await _db.db;
    String sql = "SELECT * FROM $nomeTabela ORDER BY nome ASC";
    List imc = await bancoDados.rawQuery(sql);
    return imc;
  }

  // deletar informações no banco de dados
  Future<dynamic> removerImc(dynamic id) async {
    var bancoDados = await _db.db;
    return await bancoDados
        .delete(nomeTabela, where: "id = ?", whereArgs: [id]);
  }

  // atualizar informações no banco de dados
  Future<dynamic> atualizarImc(Imc imc) async {
    var bancoDados = await _db.db;
    return await bancoDados
        .update(nomeTabela, imc.toMap(), where: "id = ?", whereArgs: [imc.id]);
  }
}
