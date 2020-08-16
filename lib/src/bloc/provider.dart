import 'package:flutter/cupertino.dart';
import 'package:soporte_moviles/src/bloc/login_bloc.dart';
import 'package:soporte_moviles/src/bloc/sedes_bloc.dart';

class Provider extends InheritedWidget {
  final sedesBloc = SedesBloc();
  final loginBloc = LoginBloc();

  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }

    return _instancia;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static SedesBloc sedesbloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().sedesBloc;
  }

  static LoginBloc loginbloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }
}
