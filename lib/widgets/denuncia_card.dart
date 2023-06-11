import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projeto_app_denuncia/classes/denuncia.dart';
import 'package:url_launcher/url_launcher.dart';

import '../pages/detalhes_denuncia.dart';

class DenunciaCard extends StatefulWidget {
  @override
  _DenunciaCardState createState() => _DenunciaCardState();

  Denuncia denuncia;
  Function() refreshHome;

  DenunciaCard({Key? key, required this.denuncia, required this.refreshHome})
      : super(key: key);
}

class _DenunciaCardState extends State<DenunciaCard> {
  bool isBase64() {
    try {
      base64.decode(widget.denuncia.image1);
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => DetalhesDenunciaPage(
                  denuncia: widget.denuncia,
                  refreshHome: widget.refreshHome,
                ),
              ));
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: isBase64()
                          ? SizedBox(
                              height: 150,
                              width: 115,
                              child: Card(
                                elevation: 0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.memory(
                                    base64.decode(widget.denuncia.image1),
                                    fit: BoxFit.fill,
                                    filterQuality: FilterQuality.medium,
                                    gaplessPlayback: true,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Icon(
                                        Icons.image_outlined,
                                        size: 35,
                                        color: Theme.of(context).hintColor,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 150,
                              width: 115,
                              child: Card(
                                elevation: 0,
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 35,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.denuncia.shortDescription,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Visibility(
                          visible: widget.denuncia.description.isNotEmpty,
                          child: Text(
                            widget.denuncia.description,
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor),
                          ),
                        ),
                        Text(
                          "Latitude: ${widget.denuncia.latitude}",
                          style: TextStyle(
                              fontSize: 14, color: Theme.of(context).hintColor),
                        ),
                        Text(
                          "Longitude: ${widget.denuncia.longitude}",
                          style: TextStyle(
                              fontSize: 14, color: Theme.of(context).hintColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
