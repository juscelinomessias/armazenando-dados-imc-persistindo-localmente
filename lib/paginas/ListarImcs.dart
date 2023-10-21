import 'package:aprimorando_calculadora_de_imc/dao/sql/ImcDAO.dart';
import 'package:aprimorando_calculadora_de_imc/modelos/Imc.dart';
import 'package:aprimorando_calculadora_de_imc/paginas/home_page.dart';
import 'package:flutter/material.dart';

class ListarImc extends StatefulWidget {
  const ListarImc({Key? key}) : super(key: key);

  @override
  _ListarImcState createState() => _ListarImcState();
}

class _ListarImcState extends State<ListarImc> {
  // acessar banco de dados
  final ImcDAO _db = ImcDAO();

  // criar lista com dados recuperados
  List<Imc> _imcs = [];

  @override
  void initState() {
    super.initState();
    _recuperarImcs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xff533753),
        ),
        title: const Text("Últimos cálculos"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    itemCount: _imcs.length,
                    itemBuilder: (context, index) {
                      final usuario = _imcs[index];
                      return Card(
                        color: const Color(0xFF533753),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.fromLTRB(16, 5, 10, 5),
                          title: Text(
                            usuario.nome,
                            style: const TextStyle(color: Color(0xffffc906)),
                          ),
                          subtitle: Text(
                            "Imc: ${usuario.resultado}\nPeso: ${usuario.peso} - Altura: ${usuario.altura!}",
                            style: const TextStyle(color: Color(0xffffffff)),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _alertaDeConfirmacao(usuario.id!);
                                },
                                icon: const Icon(Icons.delete_outlined,
                                    color: Color(0xFFf0c82f)),
                              )
                            ],
                          ),
                        ),
                      );
                    })),
            Container(
                height: 65,
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1.0, color: Color(0xff000000)))),
                child: GestureDetector(
                  child: Container(
                    height: 65.0,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: const Center(
                      child: Text(
                        "Tela Inicial",
                        style:
                            TextStyle(color: Color(0xff533753), fontSize: 17),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                ))
          ],
        ),
      ),
    );
  }

  // alerta de confimação para deletar item
  _alertaDeConfirmacao(dynamic id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      "Excluir",
                      style: TextStyle(
                          color: Color(0xff533753),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    top: -90,
                    child: CircleAvatar(
                      backgroundColor: Color(0xff533753),
                      radius: 60,
                      child: Icon(
                        Icons.delete_outlined,
                        color: Color(0xffffc906),
                        size: 60,
                      ),
                    ),
                  )
                ]),
            content: const Text(
              "Deseja excluir o IMC?",
              style: TextStyle(color: Color(0xff533753), fontSize: 17),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _removerAnotacao(id);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff533753),
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(40, 10, 40, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    child: const Text(
                      "Sim",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffffc906),
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(40, 10, 40, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    child: const Text(
                      "Não",
                      style: TextStyle(color: Color(0xff533753), fontSize: 17),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          );
        });
  }

  // recupera informações do banco de dados
  _recuperarImcs() async {
    List imcsRecuperados = await _db.recuperarImc();
    List<Imc> listaTemporaria = [];

    for (var item in imcsRecuperados) {
      Imc imc = Imc.fromMap(item);
      listaTemporaria.add(imc);
    }

    setState(() {
      _imcs = listaTemporaria;
    });

    //listaTemporaria.clear();

    print("Lista imcs: " + imcsRecuperados.toString());
  }

  // deletar informaçao no banco de dados
  _removerAnotacao(dynamic id) async {
    await _db.removerImc(id);
    _recuperarImcs();

    // Remove o SnackBar caso esteja aberto
    ScaffoldMessenger.of(context).clearSnackBars();

    // Exibe uma mensagem quando o IMC é excluído
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Text(
            "IMC excluído com sucesso!",
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
