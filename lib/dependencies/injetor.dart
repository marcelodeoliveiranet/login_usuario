import 'package:get_it/get_it.dart';
import 'package:login_usuario/controllers/login_controller.dart';
import 'package:login_usuario/controllers/usuario_controller.dart';
import 'package:login_usuario/services/login_service.dart';
import 'package:login_usuario/services/shared_preferences_service.dart';

final getIt = GetIt.instance;

void setupInjector() {
  getIt.registerSingleton<UsuarioController>(UsuarioController());
  getIt.registerSingleton<SharedPreferencesService>(SharedPreferencesService());
  getIt.registerSingleton<LoginService>(LoginService());
  getIt.registerSingleton<LoginController>(
    LoginController(sharedPreferences: getIt(), loginService: getIt()),
  );
}
