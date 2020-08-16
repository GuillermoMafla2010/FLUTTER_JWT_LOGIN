

import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:soporte_moviles/src/backend/api_rest.dart';
import 'package:soporte_moviles/src/modelos/persona.dart';

class SedesBloc{

 
 final _personasProvider = new RestProvider();

  //Crea el stream
  final _sedesController = new BehaviorSubject<List<Persona>>();

 

 //Informacion que sale del stream
 Stream <List<Persona>> get sedesStream => _sedesController.stream;


  void cargarSedes() async{

    final sedes=await _personasProvider.getTodos();
    _sedesController.sink.add(sedes);
    
  }

  dispose(){
    _sedesController?.close();
  }


}