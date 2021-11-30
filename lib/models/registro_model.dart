class Registro{
  int? id;
  String? nombre;
  String? grado;
  String? curso;


  Registro({
    this.nombre,
    this.grado,
    this.curso,
});

  Registro.whitId({
    this.id,
    this.nombre,
    this.grado,
    this.curso
  });

  Map<String, dynamic> toMap(){
    final map =Map<String, dynamic>();

    if(id != null){
      map['id']=id;
    }

    map['nombre']=nombre;
    map['grado']=grado;
    map['curso']=curso;
    return map;
  }

  factory Registro.fromMap(Map<String, dynamic> map){
    return Registro.whitId(
      id:map['id'],
      nombre:map['nombre'],
      grado:map['grado'],
      curso:map['curso'],
    );
  }



}