import 'package:flutter/material.dart';
import 'package:soporte_moviles/src/pages/login.dart';
import 'package:soporte_moviles/src/shared_preferences/preferencias.dart';

class Menu_Principal extends StatefulWidget {
  @override
  _Menu_PrincipalState createState() => _Menu_PrincipalState();
}

class _Menu_PrincipalState extends State<Menu_Principal> {
  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
    print(prefs.userId);
    print(prefs.token);

    
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Soporte Usuarios'),
          backgroundColor: Colors.redAccent,
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
        drawer: crearMenu(context));
  }

  Drawer crearMenu(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Container(),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://i.ytimg.com/vi/4OK4nEJQMps/maxresdefault.jpg'),
                      fit: BoxFit.cover))),
          ListTile(
              title: Text('Requerimientos'),
              leading: Icon(Icons.pages),
              onTap: () => Navigator.pushNamed(context, 'ver_requerimiento')),
          ListTile(
            title: Text('Incidencias'),
            leading: Icon(Icons.people),
            onTap: () => Navigator.pushNamed(context, 'ver_incidencia'),
          ),
          ListTile(
              title: Text('Cerrar Sesion'),
              leading: Icon(Icons.people),
              onTap: () => {
                    prefs.token = null,
                    prefs.userId = null,
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Login())),
                    print(prefs.token),
                    print(prefs.userId)
                  }),
        ],
      ),
    );
  }
}
