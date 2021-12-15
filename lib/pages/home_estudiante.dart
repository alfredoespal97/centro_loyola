import 'package:centroloyolapp/database/database.dart';
import 'package:centroloyolapp/models/estudiante_model.dart';
import 'package:centroloyolapp/models/registro_model.dart';
import 'package:centroloyolapp/pages/add_estudiante.dart';
import 'package:centroloyolapp/pages/add_registro.dart';
import 'package:centroloyolapp/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeEstudiantePage extends StatefulWidget{
  int id_registro;
  HomeEstudiantePage({required this.id_registro});

  @override
  State<HomeEstudiantePage> createState() => _HomeEstudiantePageState();

}

class _HomeEstudiantePageState extends State<HomeEstudiantePage>{
  late Future<List<Estudiante>> _estudianteList;
  late Future<List<Registro>> _registroList;
  DatabaseHelper _databaseHelper=DatabaseHelper.instance;
  int? idre;

  @override
  void initState(){
    super.initState();
    idre=widget.id_registro;
    print("el registo es: $idre.");
    _updateEstudianteList();
  }

  _updateEstudianteList(){
   // _estudianteList=DatabaseHelper.instance.getEstudianteListByRegistro(idre!);
    _estudianteList=DatabaseHelper.instance.getEstudianteList();
  }


  Widget _buildEstudiante(Estudiante estudiante){
    return Padding(
        padding:EdgeInsets.symmetric(horizontal: 25.0),
        child:Column(
          children: <Widget>[
            ListTile(
              title:Text(estudiante.nombre! +' '+estudiante.apellidos!, style: TextStyle(
                fontSize: 18.0,
                color: Theme.of(context).primaryColor,
              ),),
              subtitle: Text('Edad: '+estudiante.edad!, style: TextStyle(
                fontSize: 12.0,
                color: Theme.of(context).primaryColor,
              ),),
              onTap:()=>Navigator.push(context, CupertinoPageRoute(builder: (_)=> AddEstudiantePage(
                updateEstudianteList: _updateEstudianteList(),
                estudiante: estudiante,
                id_registro: idre!,
              ))),
            ),
            Divider( height: 5.0,),
          ],
        )

    );
  }

  _updateRegistroList(){
    _registroList=DatabaseHelper.instance.getRegistroList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        //iconTheme:IconThemeData(color: Theme.of(context).primaryColor),
        actions: [
          IconButton(
              onPressed: (){
                Get.to( ()=>AddRegistroPage(
                  updateRegistroList: _updateRegistroList,
                ),);
              },
              icon: Icon(Icons.edit,color: Theme.of(context).primaryColor,))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          Navigator.push(context,CupertinoPageRoute(builder: (_)=>AddEstudiantePage(
            updateEstudianteList: _updateEstudianteList,
            id_registro: idre!,
          ),));
        },
        child: Icon(Icons.add),

      ),
      body:FutureBuilder(
                future: _estudianteList,
                builder: (context, AsyncSnapshot snapshot) {
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  //final int completeRegistroCount=snapshot.data!.where((Registro registro)=>registro.id!=null).toList.length;
                  return ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 80.0),
                      itemCount: int.parse(snapshot.data!.length.toString()) + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 20.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Mis Estudiantes', style:
                                  TextStyle(color: Colors.blue,
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10.0,),
                                  Text(
                                    '${snapshot.data!.length}', style:
                                  TextStyle(color: Colors.blue,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600),
                                  ),
                                ]
                            ),
                          );
                        }
                        return _buildEstudiante(snapshot.data![index-1]);
                      }
                  );
                }
            ),
    );
  }
}