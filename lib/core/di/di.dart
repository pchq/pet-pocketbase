import 'package:injectable/injectable.dart';
import 'di.config.dart';
import 'locator.dart';

@InjectableInit(
  initializerName: r'$configureDependencies',
  preferRelativeImports: true,
)
Future<void> configureDependencies() async => locator.$configureDependencies();
