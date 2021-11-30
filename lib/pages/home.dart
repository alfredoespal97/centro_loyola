import 'package:centroloyolapp/pages/add_registro.dart';
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
  Widget _buildRegistro(int index){
    return Padding(
        padding:EdgeInsets.symmetric(horizontal: 25.0),
        child:Column(
          children: <Widget>[
            ListTile(
              title:Text('Regitro Title'),
              subtitle: Text('Nov 16,2021'),
              trailing: Checkbox(
                onChanged: (value){
                  print(value);
                },
                activeColor: Theme.of(context).primaryColor,
                value: true,
              ),
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
          Navigator.push(context,CupertinoPageRoute(builder: (_)=>AddRegistroPage(),));
        },
        child: Icon(Icons.add),

      ),
//      appBar: AppBar(
//        title: const Text('Centro Loyola'),
//
//      ),
      body:ListView.builder(
          padding:EdgeInsets.symmetric(vertical: 80.0),
          itemCount: 10,
          itemBuilder: (BuildContext context,int index){
            if(index==0){
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Mis Registros',style:
                      TextStyle(color:Colors.blue,fontSize: 40.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0,),
                      Text(
                        '0-10',style:
                      TextStyle(color:Colors.blue,fontSize: 20.0, fontWeight: FontWeight.w600),
                      ),
                    ]
                ),
              );
            }
            return _buildRegistro(index);
          }
      ),
      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.

    );
  }
}