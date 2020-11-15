import 'package:simple_online_store_api/simple_online_store_api.dart';

Future main() async {
  final app = Application<SimpleOnlineStoreApiChannel>()
    ..options.configurationFilePath = "config.yaml"
    ..options.port = 8888;

  await app.startOnCurrentIsolate();

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}
