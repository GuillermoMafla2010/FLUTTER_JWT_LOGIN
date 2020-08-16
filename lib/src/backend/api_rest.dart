import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soporte_moviles/src/modelos/persona.dart';
import 'package:soporte_moviles/src/modelos/usuario.dart';
class RestProvider{
  
  String url='http://192.168.43.2:8000/api/sedes';

  Future<List<Persona>> getTodos() async {
   
   List<Usuario> users =new List();
    final response=await http.get(url);
    if(response.statusCode==200){
      List decodedData=json.decode(response.body);
      
      if(decodedData==null){
        return [];
      } 
    
      /* for(var i=0;i<decodedData.length;i++){
          print(decodedData[i]['users']['nombre']);
          //users.add(usuarios);
         
      } */

     decodedData.map((e)=>{
       print(e['users'])
     });

       return decodedData.map((persona) => new Persona.fromJson(persona)).toList();
    }else{
      throw Exception ('NO SE LOGRO CONECTAR CON EL ENDPOINT');
    }

    

    }
}

