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

class NovaDenuncia extends StatefulWidget {
  @override
  _NovaDenunciaState createState() => _NovaDenunciaState();

  Function() refreshHome;

  NovaDenuncia({Key? key, required this.refreshHome}) : super(key: key);
}

class _NovaDenunciaState extends State<NovaDenuncia> {
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
  }

  //DB
  /*void _salvarFoto() async {
    List<int> imageBytes = foto!.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    Map<String, dynamic> row = {
      dbDenuncia.columnTitulo: controllerTitulo.text,
      dbDenuncia.columnDescricao: controllerDescricao.text,
      dbDenuncia.columnLatitude: _locationData.latitude.toString(),
      dbDenuncia.columnLongitude: _locationData.longitude.toString(),
      dbDenuncia.columnFoto: base64Image,
    };
    final id = await dbDenuncia.insert(row);
  }*/

  Future<http.Response> enviarDenunciaJson() async {
    Denuncia denunciaJson = Denuncia(
        null,
        controllerShortDescription.text,
        controllerDescription.text,
        base64String,
        "null",
        "null",
        false,
        _locationData.latitude.toString(),
        _locationData.longitude.toString());

    var response = await http.post(
      Uri.parse('http://177.44.248.13:5000/alertas_insert_json'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(denunciaJson.toJson()),
    );

    //print(denunciaJson.toJson());
    print("Resposta: ${response.statusCode}");
    return response;
  }

  void enviarDenunciaForm() async {
    //http://177.44.248.13:5000/alertas_insert_form?description=morreu&shortdescription=vaca

    String sendToApi = "http://177.44.248.13:5000/alertas_insert_form?";
    String desc = "description=${controllerShortDescription.text}";
    sendToApi += desc;
    String shortDesc = "&shortdescription=${controllerDescription.text}";
    sendToApi += shortDesc;

    String image1 = "";
    if (base64String.isNotEmpty) {
      image1 = "&image1=$base64String";
    } else {
      image1 = "&image1=null";
    }

    sendToApi += image1;
    String image2 = "&image2=null";
    sendToApi += image2;
    String image3 = "&image3=null";
    sendToApi += image3;
    String active = "&active=true";
    sendToApi += active;
    String latitude = "&latitude=${_locationData.latitude}";
    sendToApi += latitude;
    String longitude = "&longitude=${_locationData.longitude}";
    sendToApi += longitude;

    final Uri url = Uri.parse(sendToApi);

    // EX Gerado OK
    //http://177.44.248.13:5000/alertas_insert_form?description=testezao&shortdescription=testezinho&image1=null&image2=null&image3=null&active=true&latitude=37.4226711&longitude=-122.0849872

    /*final response = await http.get(url);

    if (response.statusCode == 200) {
      print('Foi!');
    } else {
      print('Não foi!');
    }*/
  }

  bool validarTextFields() {
    if (controllerShortDescription.text.isEmpty) {
      tituloValido = false;
      return false;
    }
    return true;
  }

  void removerFoto() {
    setState(() {
      foto = null;
      base64String = "";
    });
  }

  void openCamera() {
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

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Denúncia'),
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
                            ? Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)),
                                width: 70,
                                height: 105,
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
                    enviarDenunciaJson().then((_) =>
                        {widget.refreshHome(), Navigator.of(context).pop()});
                  } else {
                    setState(() {
                      tituloValido;
                    });
                  }
                },
                icon: Icon(Icons.save_outlined,
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
