import 'dart:convert';
import 'dart:io';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:location/location.dart';
import 'package:projeto_app_denuncia/classes/denuncia.dart';
import 'package:projeto_app_denuncia/db/denuncia_dao.dart';
import 'package:http/http.dart' as http;

class UpdateDenuncia extends StatefulWidget {
  @override
  _UpdateDenunciaState createState() => _UpdateDenunciaState();

  Denuncia denuncia;
  Function() refreshHome;

  UpdateDenuncia({Key? key, required this.refreshHome, required this.denuncia})
      : super(key: key);
}

class _UpdateDenunciaState extends State<UpdateDenuncia> {
  final dbDenuncia = DenunciaDao.instance;
  late LocationData _locationData;
  TextEditingController controllerShortDescription =
      TextEditingController(); //  titulo
  TextEditingController controllerDescription = TextEditingController();
  late FocusNode inputFieldNode;
  bool tituloValido = true;

  bool viewImageDebug = false;

  final photos = <File>[];
  File? foto;
  String base64String = "";

  @override
  void initState() {
    super.initState();
    getLocationData();

    if(!isBase64()) {
      widget.denuncia.image1 = "";
    }

    controllerDescription.text = widget.denuncia.description;
    controllerShortDescription.text = widget.denuncia.shortDescription;
  }

  bool isBase64() {
    try {
      base64.decode(widget.denuncia.image1);
      return true;
    } catch (error) {
      return false;
    }
  }


  Future<http.Response> updateDenunciaJson() async {

    Denuncia denunciaJson = Denuncia(
        widget.denuncia.id,
        controllerShortDescription.text,
        controllerDescription.text,
        base64String.isEmpty ? widget.denuncia.image1 : base64String,
        "null",
        "null",
        false,
        _locationData.latitude.toString(),
        _locationData.longitude.toString());

    //alertas_update_json

    var response = await http.post(
      Uri.parse('http://177.44.248.13:5000/alertas_update_json'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(denunciaJson.toJsonComId()),
    );

    print(jsonEncode(denunciaJson.toJsonComId()));
    print("Resposta: ${response.statusCode}");
    return response;
  }

  bool validarTextFields() {
    if (controllerShortDescription.text.isEmpty) {
      tituloValido = false;
      return false;
    }
    return true;
  }

  void removerFoto() {
    loseFocus();

    setState(() {
      foto = null;
      base64String = "";
    });
  }

  void openCamera() {
    loseFocus();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CameraCamera(
                  onFile: (file) {
                    photos.add(file);
                    Navigator.pop(context);
                    compactarSetarFoto();
                  },
                )));
  }

  void compactarSetarFoto() async {
    setState(() {
      foto = photos[0];
    });

    File? compressedFile = await FlutterNativeImage.compressImage(foto!.path,
        quality: 50, targetWidth: 300, targetHeight: 400);

    final bytes = compressedFile.readAsBytesSync();
    base64String = base64Encode(bytes);

    setState(() {
      base64String;
    });
  }

  void getLocationData() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
  }

  void loseFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Atualizar Denúncia'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              // autofocus: true,
              minLines: 1,
              maxLines: 3,
              maxLength: 200,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.name,
              controller: controllerShortDescription,
              onEditingComplete: () => node.nextFocus(),
              decoration: InputDecoration(
                  helperText: "* Obrigatório",
                  labelText: "Título",
                  errorText: tituloValido ? null : "Título vazio"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              minLines: 1,
              maxLines: 2,
              maxLength: 150,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.name,
              controller: controllerDescription,
              onEditingComplete: () => node.nextFocus(),
              decoration: const InputDecoration(
                labelText: "Descrição",
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 0, 25, 10),
            child: Text(
              "Foto",
              style: TextStyle(fontSize: 16),
            ),
          ),
          ListTile(
            title: Card(
              margin: const EdgeInsets.all(0),
              elevation: 0,
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(
                  color: Colors.grey[800]!.withOpacity(0.9),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 5, 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 0,
                        child: foto == null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.memory(
                                  base64.decode(widget.denuncia.image1),
                                  width: 70,
                                  height: 105,
                                  fit: BoxFit.fill,
                                  filterQuality: FilterQuality.medium,
                                  gaplessPlayback: true,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.file(
                                  foto!,
                                  width: 70,
                                  height: 105,
                                  fit: BoxFit.fill,
                                ),
                              ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 175,
                            height: 40,
                            child: TextButton(
                              onPressed: openCamera,
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Theme.of(context).cardTheme.color,
                                onPrimary: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              child: const Text(
                                "Adicionar Foto",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                          foto != null
                              ? const SizedBox(
                                  height: 20,
                                )
                              : const SizedBox.shrink(),
                          foto != null
                              ? SizedBox(
                                  width: 175,
                                  height: 40,
                                  child: TextButton(
                                    onPressed: removerFoto,
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      primary:
                                          Theme.of(context).cardTheme.color,
                                      onPrimary: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .color,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                    ),
                                    child: const Text(
                                      "Remover foto",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
            child: FilledButton.tonalIcon(
                onPressed: () {
                  if (validarTextFields()) {
                    updateDenunciaJson().then((_) =>
                        {widget.refreshHome(), Navigator.of(context).pop(), Navigator.of(context).pop()});
                  } else {
                    setState(() {
                      tituloValido;
                    });
                  }
                },
                icon: Icon(Icons.send_outlined,
                    color: Theme.of(context).colorScheme.onPrimary),
                label: Text(
                  'Enviar',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                )),
          ),

          // REMOVER
          // DEBUG IMAGE
          Visibility(
            visible: viewImageDebug,
            child: Column(
              children: [
                const Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                  child: FilledButton.tonalIcon(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red.shade300,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        await Clipboard.setData(
                            ClipboardData(text: base64String));
                      },
                      icon: Icon(Icons.copy_all_outlined,
                          color: Theme.of(context).colorScheme.onPrimary),
                      label: Text(
                        'Copiar base64String',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      )),
                ),
                SelectableText(base64String),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
