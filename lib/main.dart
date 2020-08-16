import 'package:flutter/material.dart';
import 'package:soporte_moviles/src/bloc/provider.dart';
import 'package:soporte_moviles/src/pages/incidencias/ver_incidencias.dart';
import 'package:soporte_moviles/src/pages/login.dart';
import 'package:soporte_moviles/src/pages/menu_principal.dart';
import 'package:soporte_moviles/src/pages/principal.dart';
import 'package:soporte_moviles/src/pages/requerimentos/ver_requerimentos.dart';
import 'package:soporte_moviles/src/shared_preferences/preferencias.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized(); 

  final prefs=new PreferenciasUsuario();
  await prefs.initPrefs();
  
  
  runApp(MyApp());
 
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        initialRoute: 'login',
        debugShowCheckedModeBanner: false,
        routes: {
          'login': (BuildContext context) => Login(),
          'menu': (BuildContext context) => Menu_Principal(),
          'ver_incidencia': (BuildContext context) => VerIncidencias(),
          'ver_requerimiento': (BuildContext context) => VerRequerimiento(),
        },
        
      ),
    );
  }

}
