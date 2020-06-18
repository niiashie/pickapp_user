import 'package:get_it/get_it.dart';
import 'package:pickappuser/services/auth.service.dart';
import 'package:pickappuser/services/data.service.dart';
import 'package:pickappuser/services/dialog.service.dart';
import 'package:pickappuser/services/http.service.dart';
import 'package:pickappuser/services/router.service.dart';


GetIt locator = GetIt.instance;
void setupLocator(){

  locator.registerSingleton<RouterService>(RouterService());
  locator.registerSingleton<DialogService>(DialogService());
  locator.registerSingleton<HttpService>(HttpService());
  locator.registerSingleton<AuthService>(AuthService());
  //locator.registerSingleton<DataService>(DataService());
}