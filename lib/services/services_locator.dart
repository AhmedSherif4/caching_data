import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'services_locator.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();
