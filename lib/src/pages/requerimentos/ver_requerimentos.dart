import 'package:flutter/material.dart';

import 'package:soporte_moviles/src/bloc/provider.dart';
import 'package:soporte_moviles/src/bloc/sedes_bloc.dart';
import 'package:soporte_moviles/src/modelos/persona.dart';
import 'package:soporte_moviles/src/modelos/usuario.dart';


class VerRequerimiento extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<VerRequerimiento> {
   
  @override
  // ignore: must_call_super
  void initState() {
   print("");
     
  }
 
  @override

  Widget build(BuildContext context) {


    final bloc = Provider.sedesbloc(context);
    bloc.cargarSedes();
    
    

    print("HOLA CAREVERGA");
    return Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Column(
            
            children:<Widget>[

              Container(
               height:350.0,
               child:_mostrarUsuarios(bloc)
                
              ),
              Container(
                
                child:_mostrarSedes(bloc),
              )
              //_mostrarSedes(bloc),
              //SizedBox(height: 50.0,),
              
            ] 
          ),
        ));
  }

  Widget _mostrarSedes(SedesBloc sedesBloc) {
     print(sedesBloc.sedesStream);
    return StreamBuilder(
        stream: sedesBloc.sedesStream,
        builder: (BuildContext context, AsyncSnapshot <List<Persona>> snapshot) {
         
          if (snapshot.hasData) {
         return DropdownButton(
          
              items: snapshot.data
                  .map((user) => DropdownMenuItem(
                        child: Text(user.nombreSede),
                        value: user,
                      ))
                  .toList(),
              onChanged: (value) {
                print(value);
              },
            ); 
          } else if(snapshot.data==null){
            return CircularProgressIndicator();
          }
        });
  }

  Widget _mostrarUsuarios(SedesBloc sedesBloc){
    return StreamBuilder(
      stream: sedesBloc.sedesStream,
      builder: (BuildContext context , AsyncSnapshot<List<Persona>> snapshot){
        if(snapshot.hasData){
           final productos=snapshot.data;
           return ListView.builder(itemCount: productos.length, itemBuilder: (context,i)=>_crearItem(context,productos[i],productos[i].users));
        }else{
          return CircularProgressIndicator();
        }
      }
      
      );
  }

  Widget _crearItem(BuildContext context,  persona,productos){
    
    return ListTile(leading: Icon(Icons.access_alarm),title: Text(persona.nombreSede.toString()),subtitle:Text('Soportes:${productos.length.toString()}') );
  }

  
}
