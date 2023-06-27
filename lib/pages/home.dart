import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projeto_app_denuncia/db/denuncia_dao.dart';
import '../classes/denuncia.dart';
import '../util/app_details.dart';
import '../widgets/denuncia_card.dart';
import '../widgets/denuncia_card_large.dart';
import 'nova_denuncia.dart';
import 'package:http/http.dart' as http;

import 'settings/settings_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> listaFotos = [];
  final dbDenuncia = DenunciaDao.instance;
  bool loading = true;

  String urlJson = "http://177.44.248.13:5000/alertas_json";
  List<Denuncia> denunciaList = [];

  @override
  void initState() {
    super.initState();
    getAllDenuncias();
  }

  Future<void> getAllDenuncias([bool refresh = false]) async {
    if (denunciaList.isNotEmpty) {
      denunciaList.clear();
    }

    if (refresh) {
      setState(() {
        loading = true;
      });
    }

    try {
      final response = await http.get(Uri.parse(urlJson));
      if (response.statusCode == 200) {
        final List<List<dynamic>> data =
            List<List<dynamic>>.from(json.decode(response.body));

        for (var item in data) {
          final entity = Denuncia(
            item[0] as int,
            item[1] ?? "",
            item[2] ?? "",
            item[3] ?? "",
            item[4] ?? "",
            item[5] ?? "",
            item[6] ?? false,
            item[7] ?? "",
            item[8] ?? "",
          );

          denunciaList.add(entity);
        }
      } else {
        throw Exception("Resposta: ${response.statusCode}");
      }

      //print(denunciaList);
      setState(() {
        loading = false;
      });
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppDetails.appName),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.settings_outlined,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => Configs(),
                    ));
              }),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => getAllDenuncias(true),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: (loading)
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: denunciaList.length,
                      itemBuilder: (context, index) {
                        Denuncia denunciaIndex = Denuncia(
                            denunciaList[index].id,
                            denunciaList[index].shortDescription,
                            denunciaList[index].description,
                            denunciaList[index].image1,
                            null,
                            null,
                            null,
                            denunciaList[index].latitude,
                            denunciaList[index].longitude);

                        /*return HomeCardV2(
                            key: UniqueKey(), denuncia: denunciaIndex);*/

                        return DenunciaCard(
                          key: UniqueKey(),
                          denuncia: denunciaIndex,
                          refreshHome: getAllDenuncias,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_a_photo_outlined,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        onPressed: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => NovaDenuncia(
                  refreshHome: getAllDenuncias,
                ),
              ))
        },
      ),
    );
  }
}
