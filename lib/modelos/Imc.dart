class Imc {
  // define tudo que uma IMC vai ter
  dynamic? id;
  String nome = "";
  double peso = 0;
  double altura = 0;
  String resultado = "";

  Imc(this.id, this.nome, this.peso, this.altura, this.resultado);

  // transforma dados de uma Map para uma IMC
  Imc.fromMap(Map map) {
    this.id = map["id"];
    this.nome = map["nome"];
    this.peso = map["peso"];
    this.altura = map["altura"];
    this.resultado = map["resultado"];
  }

  // transforma dados de uma IMC para um Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "nome": this.nome,
      "peso": this.peso,
      "altura": this.altura,
      "resultado": this.resultado,
    };

    if (this.id != null) {
      map["id"] = this.id;
    }
    return map;
  }
}
