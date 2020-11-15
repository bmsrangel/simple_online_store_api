import 'package:hasura_connect/hasura_connect.dart';

abstract class IDatabase {
  HasuraConnect get conn;
}
