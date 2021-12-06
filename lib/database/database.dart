import 'dart:io';
import 'package:centroloyolapp/models/estudiante_model.dart';
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

  String estudianteTable= 'estudiante_table';
  String colIdEst= 'id';
  String colNombreEst= 'nombre';
  String colApellidos= 'apellidos';
  String colEdad= 'edad';
  String colEscuela='escuela';
  String colNumeroPadre='numero_padre';
  String colNumeroMadre='numero_madre';
  String colNumeroOtro ='numero_otro';
  String colDireccion='direccion';
  String colNota='nota';
  String colIdRegistro='id_registro';



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

    Batch batch = db.batch();

    // drop first

//    batch.execute("DROP TABLE IF EXISTS $registroTable ;");
//    batch.execute("DROP TABLE IF EXISTS $estudianteTable ;");
    // then create again
    batch.execute("CREATE TABLE $registroTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colNombre TEXT, $colGrado TEXT, $colCurso TEXT )");
    batch.execute("CREATE TABLE $estudianteTable($colIdEst INTEGER PRIMARY KEY AUTOINCREMENT, $colNombreEst TEXT, $colApellidos TEXT, $colEdad TEXT, $colEscuela TEXT, $colNumeroPadre TEXT, $colNumeroMadre TEXT, $colNumeroOtro TEXT, $colDireccion TEXT, $colNota TEXT, $colIdRegistro INTEGER, FOREIGN KEY($colIdRegistro) REFERENCES $registroTable($colIdRegistro) ON DELETE CASCADE )");

    List<dynamic> result = await batch.commit();

//      await db.execute(
//        'CREATE TABLE $registroTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colNombre TEXT, $colGrado TEXT, $colCurso TEXT );'
//      );
//      await db.execute(
//          'CREATE TABLE $estudianteTable($colIdEst INTEGER PRIMARY KEY AUTOINCREMENT, $colNombreEst TEXT, $colApellidos TEXT, $colEdad TEXT, $colEscuela TEXT, $colNumeroPadre TEXT, $colNumeroMadre TEXT, $colNumeroOtro TEXT, $colDireccion TEXT, $colNota TEXT, $colIdRegistro INTEGER, FOREIGN KEY($colIdRegistro) REFERENCES $registroTable($colIdRegistro) ON DELETE CASCADE );'
//      );
  }

  void _onUpgrade( Database db, int oldVersion, int newVersion ) async {

    Batch batch = db.batch();

    // drop first

    batch.execute("DROP TABLE IF EXISTS $registroTable ;");
    batch.execute("DROP TABLE IF EXISTS $estudianteTable ;");
    // then create again
    batch.execute("CREATE TABLE $registroTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colNombre TEXT, $colGrado TEXT, $colCurso TEXT )");
    batch.execute("CREATE TABLE $estudianteTable($colIdEst INTEGER PRIMARY KEY AUTOINCREMENT, $colNombreEst TEXT, $colApellidos TEXT, $colEdad TEXT, $colEscuela TEXT, $colNumeroPadre TEXT, $colNumeroMadre TEXT, $colNumeroOtro TEXT, $colDireccion TEXT, $colNota TEXT, $colIdRegistro INTEGER, FOREIGN KEY($colIdRegistro) REFERENCES $registroTable($colIdRegistro) ON DELETE CASCADE )");

    List<dynamic> result = await batch.commit();

  }

    //// Registro ////
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
    final int result= await db!.insert(
    registroTable,
    registro.toMap(),
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

  //// Estudiante ////
  Future<List<Map<String,dynamic>>> getEstudianteMapList() async{
    Database? db= await this.db;
    final List<Map<String,dynamic>> result= await db!.query(estudianteTable);
    return result;
  }

  Future<List<Estudiante>> getEstudianteList() async{
    final List<Map<String,dynamic>> estudianteMapList= await getEstudianteMapList();

    final List<Estudiante> estudianteList=[];

    estudianteMapList.forEach((estudianteMap){
      estudianteList.add(Estudiante.fromMap(estudianteMap));
    });

    return estudianteList;
  }

  Future<int> insertEstudiante(Estudiante estudiante) async{
    Database? db = await this.db;
    final int result= await db!.insert(
      estudianteTable,
      estudiante.toMap(),
    );

    return result;
  }


  Future<int> updateEstudiante(Estudiante estudiante) async{
    Database? db = await this.db;
    final int result= await db!.update(
        estudianteTable,
        estudiante.toMap(),
        where: '$colIdEst = ?',
        whereArgs: [estudiante.id]
    );

    return result;
  }


  Future<int> deleteEstudiante(int id) async{
    Database? db = await this.db;
    final int result= await db!.delete(
        estudianteTable,
        where: '$colIdEst = ?',
        whereArgs: [id]
    );

    return result;
  }

}