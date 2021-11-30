import 'package:centroloyolapp/pages/home.dart';
import 'package:flutter/material.dart';

class AddRegistroPage extends StatefulWidget {
  @override
  _AddRegistroPageState createState() => _AddRegistroPageState();
}

class _AddRegistroPageState extends State<AddRegistroPage> {

  final _formKey=GlobalKey<FormState>();

  String _grado='Primer Grado';
  String titleText='Agregar Registro';

  final List<String> _grados=['Primer Grado','Segungo Grado','Tercer Grado',
  'Cuarto Grado','Quinto Grado','Sexto Grado',
  'Septimo Grado','Octavo Grado','Noveno Grado'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){},
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal:40.0,vertical: 80.0 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> MyHomePage(title: 'Centro Loyola'),)),
                  child: Icon(
                    Icons.arrow_back,
                    size: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 20.0,),
                Text(
                  titleText,
                  style: TextStyle(
                      color:Colors.blue,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 20.0,),
                Form(
                  key: _formKey,
                  child:Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            decoration: InputDecoration(
                              labelText:'Nombre',
                              labelStyle: TextStyle(fontSize: 18.0,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: DropdownButtonFormField(
                            items: _grados.map((String grado){
                              return DropdownMenuItem(
                                value: grado,
                                child:Text(
                                    grado,
                                    style:TextStyle(
                                      color:Colors.black,
                                      fontSize: 18.0,
                                    )
                                ),
                              );
                            }).toList(),
                            style: TextStyle(fontSize: 18.0),
                            decoration: InputDecoration(
                              labelText: 'Grado',
                              labelStyle: TextStyle(fontSize: 18.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onChanged: (value){
                              setState((){
                                _grado=value.toString();
                              });
                            },
                            value: _grado,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            decoration: InputDecoration(
                              labelText:'Curso',
                              labelStyle: TextStyle(fontSize: 18.0,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin:EdgeInsets.symmetric(vertical: 20.0),
                          height: 60.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child:ElevatedButton(
                            child: Text(titleText,style:TextStyle(color:Colors.white,fontSize: 20.0)),
                            onPressed: (){},
                          ),
                        )
                      ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
