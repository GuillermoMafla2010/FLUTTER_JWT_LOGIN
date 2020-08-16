import 'package:rxdart/rxdart.dart';
import 'package:soporte_moviles/src/bloc/validaciones/validators.dart';

class LoginBloc with Validators{


  final emailController= new BehaviorSubject<String>();
  final passwordController= new BehaviorSubject<String>();


  //Recuperar los datos del Stream
  Stream<String> get emailStream=>emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream=>passwordController.stream.transform(validarPassword);
  Stream<bool> get formValidStream => Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);


  //Insertar datos al stream
  Function(String)get changeEmail=>emailController.sink.add;
  Function(String)get changePassword=>passwordController.sink.add;

  //Obtiene el valor de los streams
  String get email=>emailController.value;
  String get password=>passwordController.value;

  dispose(){
    emailController?.close();
    passwordController?.close();
  }

}