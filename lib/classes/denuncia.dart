import 'dart:convert';
import 'package:dynamic_value/dynamic_value.dart';

class Denuncia {
  int _id;
  String? _shortDescription;
  String? _description;
  String? _image1;
  String? _image2;
  String? _image3;
  bool? _active;
  String? _latitude;
  String? _longitude;


  Denuncia(
      this._id,
      this._shortDescription,
      this._description,
      this._image1,
      this._image2,
      this._image3,
      this._active,
      this._latitude,
      this._longitude);

  String get longitude => _longitude ?? "";

  set longitude(String value) {
    _longitude = value;
  }

  String get latitude => _latitude ?? "";

  set latitude(String value) {
    _latitude = value;
  }

  bool get active => _active ?? false;

  set active(bool value) {
    _active = value;
  }

  String get image3 => _image3 ?? "";

  set image3(String value) {
    _image3 = value;
  }

  String get image2 => _image2 ?? "";

  set image2(String value) {
    _image2 = value;
  }

  String get image1 => _image1 ?? "";

  set image1(String value) {
    _image1 = value;
  }

  String get description => _description ?? "";

  set description(String value) {
    _description = value;
  }

  String get shortDescription => _shortDescription ?? "";

  set shortDescription(String value) {
    _shortDescription = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

/*  Denuncia(
      {required this.id,
      this.shortDescription,
      this.description,
      this.image1,
      this.image2,
      this.image3,
      this.active,
      this.latitude,
      this.longitude});*/

  /* factory Denuncia.fromJson(Map<String, dynamic> json) {
    final value = DynamicValue(json);

    return Denuncia(
        id: value["id"].toInt!,
        shortdescription: value["shortdescription"].toString(),
        description: value["description"].toString(),
        image1: value["image1"].toString(),
        image2: value["image2"].toString(),
        image3: value["image3"].toString(),
        active: value["active"].toBool,
        latitude: value["latitude"].toString(),
        longitude: value["longitude"].toString());
  }*/


  @override
  String toString() {
    return 'Denuncia{_id: $_id, _shortDescription: $_shortDescription, _description: $_description, _image1: $_image1, _image2: $_image2, _image3: $_image3, _active: $_active, _latitude: $_latitude, _longitude: $_longitude}';
  }

}
