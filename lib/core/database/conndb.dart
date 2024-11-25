import 'package:mysql1/mysql1.dart';

class ConnDB {
  String host = '';
  int port = 0;
  String user = '';
  String password = '';
  String database = '';
  static final ConnDB _singleton = ConnDB._internal();

  factory ConnDB() {
    return _singleton;
  }

  ConnDB._internal();

  MySqlConnection? _connection;

  Future<MySqlConnection> _getConnection() async {
    if (_connection == null) {
      final settings = ConnectionSettings(
        host: host,
        port: port,
        user: user,
        password: password,
        db: database,
      );
      _connection = await MySqlConnection.connect(settings);
    }
    return _connection!;
  }

  Future<void> open() async {
    if (_connection == null) {
      final settings = ConnectionSettings(
        host: host,
        port: port,
        user: user,
        password: password,
        db: database,
      );
      _connection = await MySqlConnection.connect(settings);
    }
  }

  Future<void> close() async {
    if (_connection != null) {
      await _connection!.close();
      _connection = null;
    }
  }

  Future<Results> query(String sql, [List<Object?>? params]) async {
    final conn = await _getConnection();
    return await conn.query(sql, params);
  }
}
