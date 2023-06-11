import 'dart:convert';

import 'package:flutter/material.dart';
import '../classes/denuncia.dart';

class DenunciaCardLarge extends StatefulWidget {
  Denuncia denuncia;

  DenunciaCardLarge({Key? key, required this.denuncia}) : super(key: key);

  @override
  _DenunciaCardLargeState createState() => _DenunciaCardLargeState();
}

class _DenunciaCardLargeState extends State<DenunciaCardLarge> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: 800,
        height: 270,
        child: InkWell(
          onTap: () {},
          child: Stack(
            children: <Widget>[
              Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: widget.denuncia.image1 == null
                      ? SizedBox(
                    width: 1500,
                    height: 185,
                    child: Image.asset(
                      'assets/mexThanos.jpg',
                      fit: BoxFit.fill,
                    ),
                  ) : SizedBox(
                    width: 1500,
                    height: 185,
                    child: Image.memory(
                      base64
                          .decode(widget.denuncia.image1),
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.medium,
                      gaplessPlayback: true,
                    ),
                  ), ),
              Positioned(
                bottom: 0,
                left: 16,
                child: SizedBox(
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.denuncia.shortDescription,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        widget.denuncia.latitude,
                        style: TextStyle(
                            fontSize: 14, color: Theme
                            .of(context)
                            .hintColor),
                      ),
                      Text(
                        widget.denuncia.longitude,
                        style: TextStyle(
                            fontSize: 14, color: Theme
                            .of(context)
                            .hintColor),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
