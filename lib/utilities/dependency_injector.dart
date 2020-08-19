import 'package:get_it/get_it.dart';
import 'package:temperature_tracker/services/log_handler.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<LogHandler>(LogHandler());
}
