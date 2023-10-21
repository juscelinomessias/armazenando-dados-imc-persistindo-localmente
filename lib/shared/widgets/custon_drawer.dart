import 'package:aprimorando_calculadora_de_imc/paginas/listarImcs.dart';
import 'package:aprimorando_calculadora_de_imc/repositorios/imc_repositorio.dart';
import 'package:flutter/material.dart';

class CustonDrawer extends StatefulWidget {
  const CustonDrawer({super.key});

  @override
  State<CustonDrawer> createState() => _CustonDrawerState();
}

class _CustonDrawerState extends State<CustonDrawer> {
  var imcRepositorio = ImcRepositorio();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.amber),
              currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset('lib/imagens/logo-imc.png')),
              accountName: const Text("Juscelino Messias"),
              accountEmail: const Text("linooow@gmail.com")),
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              width: double.infinity,
              child: const Row(
                children: [
                  Icon(Icons.format_list_bulleted),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Últimos cálculos",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff5a3353),
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ListarImc(),
                ),
              );
            },
          ),
          const Divider()
        ],
      ),
    );
  }
}
