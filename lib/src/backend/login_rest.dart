import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:soporte_moviles/src/shared_preferences/preferencias.dart';

class LoginRest {
  String url = 'http://192.168.43.2:8000/api/login';

  final _prefs= new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(String email, String password) async {
    print("CONSULTADNO");
    Map authData = {'email': email, 'password': password};

    final resp = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(authData));
    Map<dynamic, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp['success'] == true) {
      print("OK");
      final token = decodedResp['token'];
      _prefs.token=token;
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      print(decodedToken);
      _prefs.userId=decodedToken['id'];
      // Now you can use your decoded token
      print(decodedToken["id"]);
      return {'ok': true, 'mensaje': 'Bienvenido'};
    } else {
      print("FALLO");
      return {'ok': false, 'mensaje': 'Usuario o contraseña fallidos'};
    }
  }
}
