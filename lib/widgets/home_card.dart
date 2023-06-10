import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projeto_app_denuncia/classes/denuncia.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeCard extends StatefulWidget {
  @override
  _HomeCardState createState() => _HomeCardState();

  Denuncia denuncia;

  HomeCard({Key? key, required this.denuncia}) : super(key: key);
}

class _HomeCardState extends State<HomeCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                    child:
                   widget.denuncia.image1 == null
                        ?
                    SizedBox(
                            height: 150,
                            width: 115,
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Icon(
                                Icons.image_outlined,
                                size: 35,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          )
                        : SizedBox(
                             height: 150,
                             width: 115,
                             child: Card(
                               elevation: 1,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(5),
                              ),
                              child: ClipRRect(
                                 borderRadius: BorderRadius.circular(5),
                                 child: Image.memory(
                                   base64
                                       .decode(widget.denuncia.image1),
                                   fit: BoxFit.fill,
                                   filterQuality: FilterQuality.medium,
                                   gaplessPlayback: true,
                                 ),
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
                              fontSize: 14, color: Theme.of(context).hintColor),
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
              /*  Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () {},// _launchBrowser
                        icon: const Icon(Icons.open_in_browser_outlined)))*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
