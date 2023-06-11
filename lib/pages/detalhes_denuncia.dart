import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../classes/denuncia.dart';

class DetalhesDenunciaPage extends StatefulWidget {
  DetalhesDenunciaPage({Key? key, required this.denuncia, required this.refreshHome}) : super(key: key);

  Denuncia denuncia;
  Function() refreshHome;

  @override
  State<DetalhesDenunciaPage> createState() => _DetalhesDenunciaPageState();
}

class _DetalhesDenunciaPageState extends State<DetalhesDenunciaPage> {

  Future<void> delete() async {

    final url = 'http://177.44.248.13:5000/alertas_delete_form?id=${widget.denuncia.id.toString()}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == widget.denuncia.id) {
      print("OK: ${response.statusCode}");
    }
  }

  void _openLocation() {
    String latitude = widget.denuncia.latitude;
    String longitude = widget.denuncia.longitude;

    final url = 'https://www.openstreetmap.org/?mlat=$latitude&mlon=$longitude#map=15/$latitude/$longitude';

    launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes da Denúncia"),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.delete_outline,
              ),
              onPressed: () {

                // Funcional
               /* delete().then((value) => {
                  widget.refreshHome(),
                  Navigator.of(context).pop()}
                );*/

                Navigator.of(context).pop();

              }),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 320,
            child: Image.memory(
              base64
                  .decode(widget.denuncia.image1),
              fit: BoxFit.fill,
              filterQuality: FilterQuality.medium,
              gaplessPlayback: true,
            ),
          ),
          ListTile(
            title: Text("Título",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary)),
          ),
          ListTile(
            title: Text(widget.denuncia.shortDescription),
            trailing: Text("ID: ${widget.denuncia.id}"),
          ),
          ListTile(
            title: Text("Descrição",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary)),
          ),
          ListTile(
            title: Text(widget.denuncia.description),
          ),
          ListTile(
            title: Text("Localização",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary)),
          ),
          ListTile(
            title: Text("Latitude: ${widget.denuncia.latitude}\nLongitude: ${widget.denuncia.longitude}"),
            onTap: () {
              _openLocation();
            },
          ),
          const SizedBox(height: 50,)
        ],
      ),
    );
  }
}
