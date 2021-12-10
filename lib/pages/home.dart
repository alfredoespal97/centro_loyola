import 'package:centroloyolapp/database/database.dart';
import 'package:centroloyolapp/models/registro_model.dart';
import 'package:centroloyolapp/pages/add_registro.dart';
import 'package:centroloyolapp/pages/home_estudiante.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  late Future<List<Registro>> _registroList;

  DatabaseHelper _databaseHelper=DatabaseHelper.instance;


  @override
  void initState(){
    super.initState();
    _updateRegistroList();
  }

  _updateRegistroList(){
    _registroList=DatabaseHelper.instance.getRegistroList();
  }



  Widget _buildRegistro(Registro registro){
    return Padding(
        padding:EdgeInsets.symmetric(horizontal: 25.0),
        child:Column(
          children: <Widget>[
            ListTile(
              title:Text(registro.nombre!, style: TextStyle(
                fontSize: 18.0,
                color: Theme.of(context).primaryColor,
              ),),
              subtitle: Text(registro.grado! +' '+registro.curso!, style: TextStyle(
                fontSize: 12.0,
                color: Theme.of(context).primaryColor,
              ),),
              onTap:()=>Navigator.push(context, CupertinoPageRoute(builder: (_)=> HomeEstudiantePage(idRegistro: registro.id))),
//              trailing: Checkbox(
//                onChanged: (value){
//                  print(value);
//                },
//                activeColor: Theme.of(context).primaryColor,
//                value: true,
//              ),
            ),
            Divider( height: 5.0,),
          ],
        )

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          Navigator.push(context,CupertinoPageRoute(builder: (_)=>AddRegistroPage(
            updateRegistroList: _updateRegistroList,
          ),));
        },
        child: Icon(Icons.add),

      ),
//      appBar: AppBar(
//        title: const Text('Centro Loyola'),
//
//      ),
      body:FutureBuilder(

        future: _registroList,
      builder: (context, AsyncSnapshot snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          
          //final int completeRegistroCount=snapshot.data!.where((Registro registro)=>registro.id!=null).toList.length;

         // final int completeRegistroCount=snapshot.data!.where((Registro registro)=>registro.id!=null).toList.length;


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
                          'Mis Registros', style:
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
              return _buildRegistro(snapshot.data![index-1]);
            }
        );
      }
    ),
    );
  }
}