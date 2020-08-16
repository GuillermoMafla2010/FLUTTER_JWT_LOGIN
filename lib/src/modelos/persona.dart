

// To parse this JSON data, do
//
//     final persona = personaFromJson(jsonString);

import 'dart:convert';

import 'package:soporte_moviles/src/modelos/clientes.dart';
import 'package:soporte_moviles/src/modelos/usuario.dart';

Persona personaFromJson(String str) => Persona.fromJson(json.decode(str));

String personaToJson(Persona data) => json.encode(data.toJson());

class Persona {
    Persona({
        this.id,
        this.nombreSede,
        this.clientes,
        this.users
    });

    int id;
    String nombreSede;
    List<Cliente> clientes;
    List<Usuario> users;

    factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        id: json["id"],
        nombreSede: json["nombre_sede"],
         //records: new List<Record>.from(json["Records"].map((x) => Record.fromJson(x))),
        users: new List<Usuario>.from(json["users"].map((x) => Usuario.fromJson(x))),
        clientes: new List<Cliente>.from(json["clientes"].map((x) => Cliente.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre_sede": nombreSede,
         "users":new List<dynamic>.from(users.map((x) => x.toJson())),
         "clientes" : new List<dynamic>.from(clientes.map((x) => x.toJson()))
        //"users": List<Usuario>.from(users.map((x) => x)),
        //"clientes": List<Cliente>.from(clientes.map((x) => x)),
    };
}
