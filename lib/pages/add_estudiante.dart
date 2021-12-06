import 'package:centroloyolapp/database/database.dart';
import 'package:centroloyolapp/models/estudiante_model.dart';
import 'package:centroloyolapp/pages/home_estudiante.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddEstudiantePage extends StatefulWidget{
  final int? id_registro;
  final Estudiante? estudiante;
  final Function? updateEstudianteList;

  AddEstudiantePage({this.estudiante, this.updateEstudianteList, this.id_registro});

  @override
  State<StatefulWidget> createState() => _AddEstudiantePageState();
  }

class _AddEstudiantePageState extends State<AddEstudiantePage> {

  final _formKey=GlobalKey<FormState>();

  String _nombre='';
  String _apellidos='';
  String _edad='';
  String _escuela='';
  String _numeroPadre='';
  String _numeroMadre='';
  String _numeroOtro='';
  String _direccion='';
  String _nota='';
  int _idRegistro=0;
  String titleText='Agregar Estudiante';

  @override
  void initState(){
    super.initState();

    if(widget.estudiante != null){
      _nombre=widget.estudiante!.nombre!;
      _apellidos=widget.estudiante!.apellidos!;
      _edad=widget.estudiante!.edad!;
      _escuela=widget.estudiante!.escuela!;
      _numeroPadre=widget.estudiante!.numero_padre!;
      _numeroMadre=widget.estudiante!.numero_madre!;
      _numeroOtro=widget.estudiante!.numero_otro!;
      _direccion=widget.estudiante!.direccion!;
      _nota=widget.estudiante!.nota!;
      _idRegistro=widget.id_registro!;
      setState(() {
        titleText='Actualiazar Estudiante';
      });
    }
    else{
      setState(() {
        titleText='Agregar Estudiante';
      });
    }
  }

  _delete(){
    DatabaseHelper.instance.deleteEstudiante(widget.estudiante!.id!);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeEstudiantePage()));
    widget.updateEstudianteList!();
  }

  _submit(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      print('$_nombre,$_apellidos,$_edad ');

      Estudiante estudiante=Estudiante(
        nombre: _nombre,
        apellidos: _apellidos,
        edad: _edad,
        escuela: _escuela,
        numero_padre: _numeroPadre,
        numero_madre: _numeroMadre,
        numero_otro: _numeroOtro,
        direccion: _direccion,
        nota: _nota,
        id_registro: _idRegistro
      );

      if(widget.estudiante ==null){
        DatabaseHelper.instance.insertEstudiante(estudiante);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => HomeEstudiantePage()
          ),
        );
      }
      else{
        estudiante.id=widget.estudiante!.id;
        DatabaseHelper.instance.updateEstudiante(estudiante);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => HomeEstudiantePage()
          ),
        );
      }

      widget.updateEstudianteList!();
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
                  onTap: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeEstudiantePage(),)),
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
                            input!.trim().isEmpty ? 'Por favor inserte el nombre del estudiante': null,
                            onSaved: (input)=>_nombre=input!,
                            initialValue: _nombre,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            decoration: InputDecoration(
                              labelText:'Apellidos',
                              labelStyle: TextStyle(fontSize: 18.0,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (input)=>
                            input!.trim().isEmpty ? 'Por favor inserte los apellidos del estudiante': null,
                            onSaved: (input)=> _apellidos=input!,
                            initialValue: _apellidos,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            decoration: InputDecoration(
                              labelText:'Edad',
                              labelStyle: TextStyle(fontSize: 18.0,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (input)=>
                            input!.trim().isEmpty ? 'Por favor inserte la edad del estudiante': null,
                            onSaved: (input)=>_edad=input!,
                            initialValue: _edad,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            decoration: InputDecoration(
                              labelText:'Escuela',
                              labelStyle: TextStyle(fontSize: 18.0,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onSaved: (input)=> _escuela=input!,
                            initialValue: _escuela,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            decoration: InputDecoration(
                              labelText:'Número del padre',
                              labelStyle: TextStyle(fontSize: 18.0,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onSaved: (input)=> _numeroPadre=input!,
                            initialValue: _numeroPadre,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            decoration: InputDecoration(
                              labelText:'Número de la madre',
                              labelStyle: TextStyle(fontSize: 18.0,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onSaved: (input)=> _numeroMadre=input!,
                            initialValue: _numeroMadre,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            decoration: InputDecoration(
                              labelText:'Otro Número de contacto',
                              labelStyle: TextStyle(fontSize: 18.0,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onSaved: (input)=> _numeroOtro=input!,
                            initialValue: _numeroOtro,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            decoration: InputDecoration(
                              labelText:'Dirección',
                              labelStyle: TextStyle(fontSize: 18.0,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onSaved: (input)=> _direccion=input!,
                            initialValue: _direccion,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 60.0),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            decoration: InputDecoration(
                              labelText:'Nota',
                              labelStyle: TextStyle(fontSize: 18.0,),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onSaved: (input)=> _nota=input!,
                            initialValue: _nota,
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
                        widget.estudiante != null ?
                        Container(
                          margin:EdgeInsets.symmetric(vertical:20.0),
                          height: 60.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child:ElevatedButton(
                            child: Text("Eliminar Estudiante",style:TextStyle(color:Colors.white,fontSize: 20.0)),
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

