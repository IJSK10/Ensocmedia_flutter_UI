import "package:path/path.dart";
import 'package:project/src/datamodels/receivemessages.dart';
import 'package:project/src/datamodels/token.dart';
import 'package:project/src/datamodels/userchda.dart';
import "package:sqflite/sqflite.dart";

class ChatDatabase {
  static final ChatDatabase instance = ChatDatabase._init();
  ChatDatabase._init();

  static const _databaseName = 'chat_database';
  static const _tokentableName = 'token_table';
  static const _messagetableName = 'message_table';
  static const _databaseVersion = 1;

  static const _columnUid = 'uid';
  static const _columnMessagetype = 'message_type';
  static const _columnCypher = 'cypher';
  static const _columnSender = 'sender';
  static const _columnReciever = 'reciever';
  static const _columnMessageid = 'message_id';
  static const _columnDate = 'datecreated';
  static const _columnroomid = 'room_id';

  static const _columnToken = 'token';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $_tokentableName($_columnToken TEXT NOT NULL)''');
    await db.execute(
        '''CREATE TABLE $_messagetableName($_columnUid TEXT PRIMARY KEY NOT NULL, $_columnMessagetype TEXT NOT NULL, $_columnCypher TEXT, $_columnSender TEXT NOT NULL, $_columnReciever TEXT NOT NULL, $_columnMessageid TEXT NOT NULL, $_columnDate DATETIME NOT NULL, $_columnroomid TEXT NOT NULL)''');
  }

  Future<void> insertrmessage(final rmessages message) async {
    final db = await database;
    await db.insert(_messagetableName, message.toJson());
  }

  Future<int> getCount() async {
    final db = await database;
    var x = await db.rawQuery('SELECT COUNT (*) from $_messagetableName');
    int? count = await Sqflite.firstIntValue(x);
    if (count != null) {
      return count;
    } else {
      return -1;
    }
  }

  Future<void> inserttoken(final tokendata token) async {
    final db = await database;
    await db.insert(_tokentableName, token.toJson());
  }

  Future<tokendata> gettoken() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(_tokentableName);
    tokendata token = tokendata(token: "1");
    if (maps.isNotEmpty) {
      token = tokendata.fromjson(maps[maps.length - 1]);
    }
    return token;
  }

  Future<List<Userchda>> getUsers() async {
    print("called getusers");
    final db = await database;
    print("get database");
    List<Map<String, dynamic>> maps = await db.query(_messagetableName,
        columns: [
          _columnCypher,
          _columnSender,
          _columnReciever,
          _columnDate,
          _columnroomid
        ],
        groupBy: _columnroomid,
        having: '$_columnDate = MAX($_columnDate)',
        orderBy: "datecreated DESC");
    print("fetched users");
    List<Userchda> users = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        Userchda user = Userchda.fromjson(maps[i]);
        users.add(user);
      }
    }
    print("users length");
    print(users.length);
    return users;
  }

  Future<List<rmessages>> getChat(String roomid) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(_messagetableName,
        where: '$_columnroomid = ?',
        whereArgs: [roomid],
        orderBy: "datecreated DESC");
    List<rmessages> messages = [];
    if (maps.isNotEmpty) {
      print(maps.length);
      for (int j = 0; j < maps.length; j++) {
        rmessages message = rmessages.fromjson(maps[j]);
        messages.add(message);
      }
    }
    print("message length");
    print(messages.length);
    return messages;
  }
}
