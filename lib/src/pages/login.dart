import 'package:flutter/material.dart';
import 'package:soporte_moviles/src/backend/login_rest.dart';
import 'package:soporte_moviles/src/bloc/login_bloc.dart';
import 'package:soporte_moviles/src/bloc/provider.dart';
import 'package:soporte_moviles/src/pages/menu_principal.dart';
import 'package:soporte_moviles/src/shared_preferences/preferencias.dart';

class Login extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Login> {
  final loginRest = new LoginRest();
  bool loading = false;
  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('El token es ${prefs.token}');
    if (prefs.token != '') {
      Future.delayed(const Duration(milliseconds: 1), () {
          _accederLogin();
      });
   
    }else if(prefs.token==''){
        print('NO EXISTE TOKEN');
    }
  }

  @override
  Widget build(BuildContext context) {
    final login = Provider.loginbloc(context);
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 190.0),
            children: <Widget>[
              crearUsuario(login),
              SizedBox(height: 15.0),
              crearPassword(login),
              SizedBox(height: 15.0),
              //crearSelect()
              botonEntrar(login),
              SizedBox(height: 15.0),

              if (loading) mostrarProgreso()
            ]),
      ),
    );
  }

  void _accederLogin() {
   Navigator.pushReplacementNamed(context, 'menu');
}

  Widget mostrarProgreso() {
    return Container(
        alignment: Alignment.center,
        //width: 5.0,
        height: 30.0,
        child: CircularProgressIndicator(
          backgroundColor: Colors.redAccent,
          strokeWidth: 4.0,
        ));
  }

  Widget crearUsuario(LoginBloc login) {
    return StreamBuilder(
        stream: login.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
              child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: "Pon tu nombre",
                      labelText: ("Nombre"),
                      errorText: snapshot.error),
                  onChanged: login.changeEmail));
        });
  }

  Widget crearPassword(LoginBloc login) {
    return StreamBuilder(
        stream: login.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return TextField(
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                hintText: "Pon tu contraseña",
                labelText: ("Contraseña"),
                errorText: snapshot.error),
            onChanged: login.changePassword,
          );
        });
  }

  Widget botonEntrar(LoginBloc login) {
    return StreamBuilder(
        stream: login.formValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return RaisedButton(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                child: Text('Ingresar'),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 0.0,
              color: Colors.deepPurple,
              textColor: Colors.white,
              onPressed: snapshot.hasData
                  ? () => _comprobarLogin(login, context)
                  : null);
        });
  }

  _comprobarLogin(LoginBloc login, BuildContext context) async {
    setState(() {
      loading = true;
    });

    Map<String, dynamic> info =
        await loginRest.login(login.email, login.password);
    if (info['ok']) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Menu_Principal()));
      setState(() {
        loading = false;
      });
      //mostrarAlert(context, info['mensaje']);
    } else {
      mostrarAlert(context, info['mensaje']);
      setState(() {
        loading = false;
      });
    }

    //
  }

  mostrarAlert(context, mensaje) {
    final snackbar = SnackBar(
        content: Text(mensaje),
        action: SnackBarAction(
          label: 'Cerrar',
          onPressed: () {
            // Some code to undo the change.
          },
        ));

    Scaffold.of(context).showSnackBar(snackbar);
  }
}

/* Widget crearSelect() {
    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30.0),
        FutureBuilder(
            future: personas.getTodos(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                List<Persona> datos = snapshot.data;
                return DropdownButton(
                  items: datos
                      .map((user) => DropdownMenuItem(
                            child: Text(user.nombreSede),
                            value: user,
                          ))
                      .toList(),
                  onChanged: (value) {
                    print(value);
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            })
      ],
    );
  } */
