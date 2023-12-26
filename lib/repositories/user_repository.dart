import 'package:ponto_tattoo/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserRepository {
//padrao singleton
  static final UserRepository _instace = UserRepository.internal();

  factory UserRepository() => _instace;

  UserRepository.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "pontoapp.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE ${UserModel.userAppTable}(${UserModel.userIdColumn} INTEGER PRIMARY KEY AUTOINCREMENT, ${UserModel.userIdSystemColumn} INTEGER, ${UserModel.userLoginColumn} TEXT, ${UserModel.userTypeProfileColumn} INTEGER, ${UserModel.userNameColumn} TEXT, ${UserModel.userCityColumn} TEXT, ${UserModel.userTypePlanColumn} INTEGER, ${UserModel.userStatusColumn} INTEGER)");
    });
  }

  Future<UserModel> saveUser(UserModel user) async {
    Database dbMonitory = await db;
    user.idUser = await dbMonitory.insert(UserModel.userAppTable, user.toMap());
    return user;
  }

  Future<UserModel> getUser() async {
    Database dbMonitory = await db;
    List<Map> maps = await dbMonitory.query(
      UserModel.userAppTable,
      columns: [
        UserModel.userIdColumn,
        UserModel.userIdSystemColumn,
        UserModel.userLoginColumn,
        UserModel.userTypeProfileColumn,
        UserModel.userNameColumn,
        UserModel.userCityColumn,
        UserModel.userTypePlanColumn,
        UserModel.userStatusColumn
      ],
    ); //incluido
    /*where: "${UserAppModel.userIdColumn} = ?",
        whereArgs: [id]);*/
    if (maps.length > 0) {
      return UserModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  //pesquisar sobre a necessidade de db.close() todo db close
  Future<int> deleteAllUser() async {
    Database dbMonitory = await db;
    return await dbMonitory.delete(UserModel.userAppTable);
  }

  Future close() async {
    Database dbMonitory = await db;
    dbMonitory.close();
  }
}
