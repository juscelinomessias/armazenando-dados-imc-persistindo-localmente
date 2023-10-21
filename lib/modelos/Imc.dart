class Imc {
  // define tudo que um IMC vai ter
  dynamic? id;
  String nome = "";
  double peso = 0;
  double altura = 0;
  String resultado = "";

  Imc(this.id, this.nome, this.peso, this.altura, this.resultado);

  // transforma dados de um Map para um IMC
  Imc.fromMap(Map map) {
    id = map["id"];
    nome = map["nome"];
    peso = map["peso"];
    altura = map["altura"];
    resultado = map["resultado"];
  }

  // transforma dados de um IMC para um Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "nome": nome,
      "peso": peso,
      "altura": altura,
      "resultado": resultado,
    };

    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
}
