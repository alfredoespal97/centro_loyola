class Estudiante{
  int? id;
  String? nombre;
  String? apellidos;
  String? edad;
  String? escuela;
  String? numero_padre;
  String? numero_madre;
  String? numero_otro;
  String? direccion;
  String? nota;
  int? id_registro;


  Estudiante({
    this.nombre,
    this.apellidos,
    this.edad,
    this.escuela,
    this.numero_padre,
    this.numero_madre,
    this.numero_otro,
    this.direccion,
    this.nota,
    this.id_registro
  });

  Estudiante.whitId({
    this.id,
    this.nombre,
    this.apellidos,
    this.edad,
    this.escuela,
    this.numero_padre,
    this.numero_madre,
    this.numero_otro,
    this.direccion,
    this.nota,
    this.id_registro
  });

  Map<String, dynamic> toMap(){
    final map =Map<String, dynamic>();

    if(id != null){
      map['id']=id;
    }
    map['nombre']=nombre;
    map['apellidos']=apellidos;
    map['edad']=edad;
    map['escuela']=escuela;
    map['numero_padre']=numero_padre;
    map['numero_madre']=numero_madre;
    map['numero_otro']=numero_otro;
    map['direccion']=direccion;
    map['nota']=nota;
    map['id_registro']=id_registro;
    return map;
  }

  factory Estudiante.fromMap(Map<String, dynamic> map){
    return Estudiante.whitId(
      id:map['id'],
      nombre:map['nombre'],
      apellidos:map['apellidos'],
      edad:map['edad'],
      escuela:map['escuela'],
      numero_padre:map['numero_padre'],
      numero_madre:map['numero_madre'],
      numero_otro:map['numero_otro'],
      direccion:map['direccion'],
      nota:map['nota'],
      id_registro:map['id_registro'],
    );
  }



}