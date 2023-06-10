import 'dart:convert';

import 'package:flutter/material.dart';

import '../classes/denuncia.dart';

class DetalhesDenunciaPage extends StatefulWidget {
  DetalhesDenunciaPage({Key? key, required this.denuncia}) : super(key: key);

  Denuncia denuncia;

  @override
  State<DetalhesDenunciaPage> createState() => _DetalhesDenunciaPageState();
}

class _DetalhesDenunciaPageState extends State<DetalhesDenunciaPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Detalhes da Denúncia"),
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
          ),
          const SizedBox(height: 50,)
        ],
      ),
    );
  }
}
