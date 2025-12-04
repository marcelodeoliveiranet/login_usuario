import 'package:get_it/get_it.dart';
import 'package:login_usuario/controllers/usuario_controller.dart';

final getIt = GetIt.instance;

void setupInjector() {
  getIt.registerSingleton<UsuarioController>(UsuarioController());
}
