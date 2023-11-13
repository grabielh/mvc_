import 'package:flutter/material.dart';
import 'package:mvc_test/MVC_/abstrac/abstrac_datos_persona.dart';
import 'package:mvc_test/MVC_/clases/models/datos_persona.dart';

class ServiceDatosPersona extends ChangeNotifier implements CrudDatosPersonas {
  final List<DatosPersona> personas = [];

  List<DatosPersona> get list => personas;

  @override
  Future<bool> actualizar(DatosPersona persona) async {
    int index = personas.indexWhere((p) => p.id == persona.id);
    if (index != -1) {
      personas[index] = persona;
      notifyListeners();
      return true; // Devuelve verdadero si la actualización fue exitosa
    }
    return false; // Devuelve falso si la persona no se encontró para actualizar
  }

  @override
  Future<List<DatosPersona>?> buscarPorId(int id) async {
    List<DatosPersona> personasEncontradas =
        personas.where((p) => p.id == id).toList();
    //notifyListeners();

    // Si no se encuentra ninguna persona, devolver todas las personas
    return personasEncontradas.isNotEmpty ? personasEncontradas : personas;
  }

  @override
  Future<bool> eliminar(BuildContext context, int index) async {
    if (index >= 0 && index < personas.length) {
      personas.removeAt(index);
    }
    //notifyListeners();
    return true; // Devuelve verdadero si se elimina con éxito (puede agregar lógica adicional)
  }

  @override
  Future<bool> insertar(BuildContext context, DatosPersona persona) async {
    bool existeId = personas.any((p) => p.id == persona.id);
    if (existeId) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ingrese un Id diferente'),
        ),
      );
    } else {
      personas.add(persona);
      notifyListeners();
      return existeId; // Devuelve verdadero si se inserta con éxito
    }
    return existeId;
  }

  @override
  Future<List<DatosPersona>> mostrarTodas() async {
    return personas; // Devuelve todas las personas almacenadas
  }
}
