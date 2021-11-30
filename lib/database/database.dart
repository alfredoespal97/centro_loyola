import 'dart:io';
import 'package:centroloyolapp/models/registro_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static final DatabaseHelper instance=DatabaseHelper._instance();

  static Database? _db = null;

  DatabaseHelper._instance();


  String registroTable= 'registro_table';
  String colId= 'id';
  String colNombre= 'nombre';
  String colGrado= 'grado';
  String colCurso= 'curso';


  Future<Database?> get db async{
    if(_db == null){
        _db =await initDb();
    }
    return _db;
  }

  Future<Database> initDb() async{

      Directory dir=await getApplicationDocumentsDirectory();
      String path=dir.path + 'centro_loyola.db';
      final CentroLoyola=await openDatabase(
          path, version:1, onCreate: _createDb
      );
    return CentroLoyola;
  }

  void _createDb(Database db, int version) async{
      await db.execute(
        'CREATE TABLE $registroTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colNombre TEXT, $colGrado TEXT, $colCurso TEXT )'
      );
  }


  Future<List<Map<String,dynamic>>> getRegistroMapList() async{
    Database? db= await this.db;
    final List<Map<String,dynamic>> result= await db!.query(registroTable);
    return result;
  }

  Future<List<Registro>> getRegistroList() async{
    final List<Map<String,dynamic>> registroMapList= await getRegistroMapList();

    final List<Registro> registroList=[];

    registroMapList.forEach((registroMap){
      registroList.add(Registro.fromMap(registroMap));
    });

    return registroList;
  }

  Future<int> insertRegistro(Registro registro) async{
    Database? db = await this.db;
    final int result= await db!.update(
    registroTable,
    registro.toMap(),
    where: '$colId = ?',
    whereArgs: [registro.id]
    );

    return result;
  }


  Future<int> updateRegistro(Registro registro) async{
    Database? db = await this.db;
    final int result= await db!.update(
    registroTable,
    registro.toMap(),
    where: '$colId = ?',
    whereArgs: [registro.id]
    );

    return result;
  }


  Future<int> deleteRegistro(int id) async{
    Database? db = await this.db;
    final int result= await db!.delete(
    registroTable,
    where: '$colId = ?',
    whereArgs: [id]
    );

    return result;
  }

}