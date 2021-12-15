import 'package:centroloyolapp/database/database.dart';
import 'package:centroloyolapp/models/registro_model.dart';
import 'package:centroloyolapp/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRegistroPage extends StatefulWidget {
  final Registro? registro;
  final Function? updateRegistroList;

  AddRegistroPage({this.registro, this.updateRegistroList});

  @override
  _AddRegistroPageState createState() => _AddRegistroPageState();
}

class _AddRegistroPageState extends State<AddRegistroPage> {

  final _formKey=GlobalKey<FormState>();

  String _title='';
  String _curso='';
  String _grado='Primer Grado';
  String titleText='Agregar Registro';

  final List<String> _grados=['Primer Grado','Segungo Grado','Tercer Grado',
  'Cuarto Grado','Quinto Grado','Sexto Grado',
  'Septimo Grado','Octavo Grado','Noveno Grado'];

  @override
  void initState(){
    super.initState();

    if(widget.registro != null){
      _title=widget.registro!.nombre!;
      _grado=widget.registro!.grado!;
      _curso=widget.registro!.curso!;

      setState(() {
        titleText='Actualiazar Registro';
      });
    }
    else{
      setState(() {
        titleText='Agregar Registro';
      });
    }
  }

  _delete(){
  DatabaseHelper.instance.deleteRegistro(widget.registro!.id!);
  Get.off(MyHomePage());
  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyHomePage()));
  widget.updateRegistroList!();
}

  _submit(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      print('$_title,$_grado,$_curso ');

      Registro registro=Registro(nombre: _title,grado: _grado,curso: _curso );

      if(widget.registro ==null){
          DatabaseHelper.instance.insertRegistro(registro);

//          Navigator.pushReplacement(
//            context,
//           MaterialPageRoute(
//            builder: (_)=>MyHomePage(title: 'Centro Loyola',)
//          ),
//          );
        Get.off(MyHomePage());

      }
      else{
          registro.id=widget.registro!.id;
          DatabaseHelper.instance.updateRegistro(registro);
//          Navigator.pushReplacement(
//            context,
//              MaterialPageRoute(
//                builder: (_)=>MyHomePage(title: 'Centro Loyola',)
//            ),
//          );
        Get.off(MyHomePage());
      }

      widget.updateRegistroList!();
    }
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal:40.0,vertical: 80.0 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: ()=> Get.off(MyHomePage()),
                      //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> MyHomePage(),),(route) => false),
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
                            validator: (input)=>
                             input!.trim().isEmpty ? 'Por favor inserte un nombre para el registro': null,
                            onSaved: (input)=>_title=input!,
                            initialValue: _title,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: DropdownButtonFormField(
                            isDense: true,
                            icon: Icon(Icons.arrow_drop_down_circle),
                            iconSize: 22.0,
                            iconEnabledColor: Theme.of(context).primaryColor,
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
                            validator: (input)=>_grado==null ? 'Por favor seleccione un grado':null,
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
                            onSaved: (input)=>_curso=input!,
                            initialValue: _curso,
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
                            onPressed: _submit,
                          ),
                        ),
                        widget.registro != null ?
                            Container(
                              margin:EdgeInsets.symmetric(vertical:20.0),
                              height: 60.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color:Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child:ElevatedButton(
                                child: Text("Eliminar Registro",style:TextStyle(color:Colors.white,fontSize: 20.0)),
                                onPressed: _delete,
                              ),
                            )
                            : SizedBox.shrink(),
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
