import 'package:flutter/material.dart';
import 'package:mvc_test/MVC_/clases/models/datos_persona.dart';

abstract class CrudDatosPersonas {
  Future<bool> insertar(BuildContext context, DatosPersona persona);
  Future<List<DatosPersona>> mostrarTodas();
  Future<bool> actualizar(DatosPersona persona);
  Future<bool> eliminar(BuildContext context, int id);
  Future<List<DatosPersona>?> buscarPorId(int id);
}
