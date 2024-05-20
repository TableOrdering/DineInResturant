import 'package:dine_in_resturant/app/start.dart';

import 'app/app.dart';

/// [main] is the entry point of the application.
Future<void> main() async => await startApplication(() => const Application());
/*
/// Release Command with hidden Packages 
// flutter build apk --split-per-abi --split-debug-info=path/to/mapping/directory --obfuscate --release

/// Relase Build Without Hidding Package
// flutter build apk --split-per-abi

/// Chrome Build and Release Things 
// flutter run -d chrome --web-port=6969  --web-browser-flag "--disable-web-security"
 flutter build web --web-renderer html --release
 firebase init hosting
 "target": "ecomcrm",
 firebase target:apply hosting ecomcrm ecomcrm
 firebase deploy --only hosting:ecomcrm 
*/  