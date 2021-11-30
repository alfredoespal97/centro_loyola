import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static final DatabaseHelper instance=DatabaseHelper._instance();

  static Database? _db=null;

  DatabaseHelper._instance();


  String registroTable= 'registro_table';
  String colId= 'id';
  String colNombre= 'nombre';
  String colGrado= 'grado';
  String colCurso= 'curso';

}