import 'package:flutter/material.dart';
import 'package:soporte_moviles/src/backend/api_rest.dart';
import 'package:soporte_moviles/src/modelos/persona.dart';
import 'package:soporte_moviles/src/pages/login.dart';

class Principal extends StatelessWidget {

  final personas=new RestProvider();
  
 
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Soporte a Usuarios Udla'),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
          leading: IconButton(
              icon: Icon(Icons.send), onPressed: () => print("HIJUEPUTA HUeleverga")),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () => print(personas.getTodos()))
          ],
        ),


     

    );
}

}







/* body: FutureBuilder<List<Persona>>(
  
  future: personas.getTodos(),
  builder: (context,snapshot){
    if(snapshot.hasData){
      List<Persona>datos=snapshot.data;
      
      
      return _obtieneDatos(datos);
    }else{
      return Container(
        height:400.0,
        child: Center(
          child:CircularProgressIndicator()
        ),
      );
    }
  }
  
  ),
        
             );


  }


  ListView _obtieneDatos(datos){
  Divider();  
  return ListView.builder(
    itemCount: datos.length,
    itemBuilder:(context,index){
      return _tile(datos[index].nombre_sede,datos[index].id);
      
    },
    
    );


 
}
 ListTile _tile(title,id)=>ListTile(
        title:Text(title.toString()),
        onTap: (()=>print(id)),
        
  ); 
 */
  