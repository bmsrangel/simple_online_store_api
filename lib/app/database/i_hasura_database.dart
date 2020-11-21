import 'package:hasura_connect/hasura_connect.dart';

abstract class IHasuraDatabase {
  HasuraConnect get conn;
}
