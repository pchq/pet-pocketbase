import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'di.config.dart';

@InjectableInit(
  initializerName: r'$configureDependencies',
  preferRelativeImports: false,
  asExtension: false,
)
Future<void> configureDependencies(GetIt locator) async {
  await $configureDependencies(locator);
}
