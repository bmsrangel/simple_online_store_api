import 'package:dotenv/dotenv.dart' show load, env;
import 'package:hasura_connect/hasura_connect.dart';
import 'package:injectable/injectable.dart';

import 'i_database.dart';

@LazySingleton(as: IDatabase)
class HasuraDatabase implements IDatabase {
  HasuraDatabase() {
    load();
    _url = env["HASURA_URL"];
    _adminSecret = env["HASURA_ADMIN_SECRET"];
    _database = HasuraConnect(_url, headers: {
      'x-hasura-admin-secret': _adminSecret,
    });
  }

  HasuraConnect _database;
  String _url;
  String _adminSecret;

  @override
  HasuraConnect get conn => _database;
}
