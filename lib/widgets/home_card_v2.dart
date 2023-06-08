import 'dart:convert';

import 'package:flutter/material.dart';
import '../classes/denuncia.dart';

class HomeCardV2 extends StatefulWidget {
  Denuncia denuncia;

  HomeCardV2({Key? key, required this.denuncia}) : super(key: key);

  @override
  _HomeCardV2State createState() => _HomeCardV2State();
}

class _HomeCardV2State extends State<HomeCardV2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        width: 800,
        height: 250,
        child: Stack(
          children: <Widget>[
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 5,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    width: 1500,
                    height: 160,
                    child: Image.asset(
                      'assets/mexThanos.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 10,
              child: SizedBox(
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.denuncia.shortDescription,
                      style: TextStyle(
                          fontSize: 14, color: Theme.of(context).hintColor),
                    ),
                    Text(
                      widget.denuncia.latitude,
                      style: TextStyle(
                          fontSize: 14, color: Theme.of(context).hintColor),
                    ),
                    Text(
                      widget.denuncia.longitude,
                      style: TextStyle(
                          fontSize: 14, color: Theme.of(context).hintColor),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
