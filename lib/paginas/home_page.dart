import 'package:aprimorando_calculadora_de_imc/dao/sql/ImcDAO.dart';
import 'package:aprimorando_calculadora_de_imc/modelos/Imc.dart';
import 'package:aprimorando_calculadora_de_imc/repositorios/imc_repositorio.dart';
import 'package:aprimorando_calculadora_de_imc/servicos/calcular_imc_servico.dart';
import 'package:aprimorando_calculadora_de_imc/shared/widgets/custon_drawer.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // acessar banco de dados
  final ImcDAO _db = ImcDAO();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();

  var imcRepositorio = ImcRepositorio();
  var _imcs = const <Imc>[];

  late Box storageHive;

  @override
  void initState() {
    super.initState();
    carregarDados();
    obterImcs();
  }

  void carregarDados() async {
    final storageSharedPreferences = await SharedPreferences.getInstance();
    final nome = storageSharedPreferences.getString("nome");
    final altura = storageSharedPreferences.getString("altura");

    if (nome != null && altura != null) {
      setState(() {
        _nomeController.text = nome;
        _alturaController.text = altura;
      });
    }
  }

  void obterImcs() async {
    _imcs = await imcRepositorio.listarImcs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("IMC")),
      drawer: const CustonDrawer(),
      body: PageView(
        children: [
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        Expanded(
                          flex: 5,
                          child: Image.asset(
                            'lib/imagens/logo-imc.png',
                            height: 250,
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Calculadora de IMC",
                        style: TextStyle(
                            fontSize: 26,
                            color: Color(0xff9e5696),
                            fontWeight: FontWeight.w700)),
                    const Text("Como está a sua saúde?",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff5a3353),
                            fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        controller: _nomeController,
                        style: const TextStyle(color: Color(0xFF9d5596)),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 16, 26, 16),
                          hintText: "Nome",
                          hintStyle: const TextStyle(color: Color(0xff9e5696)),
                          filled: true,
                          fillColor: const Color(0xFFffffff),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(
                            Icons.account_circle,
                            color: Color(0xff9e5696),
                            size: 27,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        controller: _pesoController,
                        style: const TextStyle(color: Color(0xFF9d5596)),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 16, 26, 16),
                          hintText: "Peso",
                          hintStyle: const TextStyle(color: Color(0xff9e5696)),
                          filled: true,
                          fillColor: const Color(0xFFffffff),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(
                            Icons.speed,
                            color: Color(0xff9e5696),
                            size: 27,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        controller: _alturaController,
                        style: const TextStyle(color: Color(0xFF9d5596)),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 16, 26, 16),
                          hintText: "Altura",
                          hintStyle: const TextStyle(color: Color(0xff9e5696)),
                          filled: true,
                          fillColor: const Color(0xFFffffff),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(
                            Icons.man,
                            color: Color(0xff9e5696),
                            size: 27,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: TextButton(
                          onPressed: () async {
                            final storageSharedPreferences =
                                await SharedPreferences.getInstance();

                            final nome = _nomeController.text ?? "";
                            final peso =
                                double.tryParse(_pesoController.text) ?? 0.0;
                            final altura =
                                double.tryParse(_alturaController.text) ?? 0.0;
                            final resultadoImc =
                                await CalcularImcServico.calcularImc(
                                    peso, altura);

                            storageSharedPreferences.setString(
                                "nome", _nomeController.text);
                            storageSharedPreferences.setString(
                                "altura", _alturaController.text);

                            _salvar();
                            setState(() => {});
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5b3353),
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                32, 16, 32, 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text(
                            "Calcular",
                            style: TextStyle(
                                color: Color(0xffffc906), fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

// salvar dados no banco
  _salvar() async {
    dynamic? id;
    String nome = _nomeController.text;
    double peso = double.tryParse(_pesoController.text) ?? 0.0;
    double altura = double.tryParse(_alturaController.text) ?? 0.0;

    final resultado = await CalcularImcServico.calcularImc(peso, altura);

    Imc imc = Imc(id, nome, peso, altura, resultado);
    dynamic resultados = await _db.salvarImc(imc);
    print("Salvar imc: " + resultados.toString());

    // limpar campos após dados serem salvos
    // _nomeController.clear();
    _pesoController.clear();
    // _alturaController.clear();

    // Remove o SnackBar caso esteja aberto
    ScaffoldMessenger.of(context).clearSnackBars();

    // Exibe uma mensagem quando a Categora é criada
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Text(
            "IMC salvo com sucesso!",
            style: TextStyle(
              color: Color(0xff000000),
              fontSize: 17,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.amber,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
