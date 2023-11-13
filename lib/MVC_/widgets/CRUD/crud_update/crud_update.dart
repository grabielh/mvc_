import 'package:flutter/material.dart';
import 'package:mvc_test/MVC_/clases/models/datos_persona.dart';
import 'package:mvc_test/MVC_/clases/service/service_datos_persona.dart';
import 'package:provider/provider.dart';

class CrudUpdateDatosPersona extends StatefulWidget {
  const CrudUpdateDatosPersona({super.key});

  @override
  State<CrudUpdateDatosPersona> createState() => _CrudInsertDatosPersonaState();
}

class _CrudInsertDatosPersonaState extends State<CrudUpdateDatosPersona> {
  final TextEditingController id = TextEditingController();
  final TextEditingController nombre = TextEditingController();
  final TextEditingController apellido = TextEditingController();
  final TextEditingController direccion = TextEditingController();
  final TextEditingController edad = TextEditingController();

  List<DatosPersona>? listaDatosPersona = [];
  late DatosPersona updateM;

  @override
  void initState() {
    super.initState();
    setState(() {
      listaDatosPersona = [];
      updateM = DatosPersona(
          id: 0, nombre: '', apellido: '', direccion: '', edad: '');
    });
  }

  @override
  Widget build(BuildContext context) {
    final datosPersona = Provider.of<ServiceDatosPersona>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Datos Persona',
          style: TextStyle(color: Colors.amber),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        width: 400,
        height: 800,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: id,
                  decoration: const InputDecoration(labelText: 'id'),
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: nombre,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: apellido,
                  decoration: const InputDecoration(labelText: 'Apellido'),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: direccion,
                  decoration: const InputDecoration(labelText: 'Direccion'),
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: edad,
                  decoration: const InputDecoration(labelText: 'Edad'),
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: 400,
                  child: ElevatedButton(
                    onPressed: () {
                      if (id.text.isEmpty ||
                          nombre.text.isEmpty ||
                          apellido.text.isEmpty ||
                          direccion.text.isEmpty ||
                          edad.text.isEmpty) {
                        // Mostrar un SnackBar indicando que faltan datos
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Por favor, complete todos los campos'),
                          ),
                        );
                      } else {
                        try {
                          final idNum = int.parse(id.text);

                          DatosPersona insertNuevoDatosPersona = DatosPersona(
                            id: idNum,
                            nombre: nombre.text,
                            apellido: apellido.text,
                            direccion: direccion.text,
                            edad: edad.text,
                          );
                          datosPersona
                              .actualizar(insertNuevoDatosPersona)
                              .then((value) {
                            // Actualizar el estado para refrescar el FutureBuilder

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Datos Actualizados correctamente'),
                              ),
                            );
                          }).catchError((e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Error al insertar los datos: $e'),
                              ),
                            );
                          });
                        } catch (e) {
                          // Mostrar un SnackBar indicando error en la conversión
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Error al convertir datos a números: $e'),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text('Actualizar Datos'),
                  ),
                ),
              ),
              //Emcabezado de la tabla !!
              SizedBox(
                width: 400,
                height: 300,
                child: Card(
                    child: _showDate(context, datosPersona, listaDatosPersona!,
                        id, nombre, apellido, direccion, edad, updateM)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _showDate(
    BuildContext context,
    ServiceDatosPersona datosPersona,
    List<DatosPersona> listaDatosPersona,
    TextEditingController id,
    TextEditingController nombre,
    TextEditingController apellido,
    TextEditingController direccion,
    TextEditingController edad,
    DatosPersona updateM) {
  return Column(
    children: [
      Container(
        alignment: Alignment.center,
        child: const Text(
          'Update',
          style: TextStyle(fontSize: 30),
        ),
      ),
      Expanded(
        child: FutureBuilder<List<DatosPersona>>(
          future: datosPersona.mostrarTodas(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('No hay respuesta de la base de datos!');
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Text('No existen Datos Registrados');
            } else {
              listaDatosPersona = snapshot.data!;
              return ListView.builder(
                itemCount: listaDatosPersona.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: IconButton(
                      onPressed: () {
                        updateM = DatosPersona(
                          id: listaDatosPersona[index].id,
                          nombre: listaDatosPersona[index].nombre,
                          apellido: listaDatosPersona[index].apellido,
                          direccion: listaDatosPersona[index].direccion,
                          edad: listaDatosPersona[index].edad,
                        );

                        // Asignar valores a los controladores de texto
                        id.text = updateM.id.toString();
                        nombre.text = updateM.nombre.toString();
                        apellido.text = updateM.apellido.toString();
                        direccion.text = updateM.direccion.toString();
                        edad.text = updateM.edad.toString();
                      },
                      icon: const Icon(Icons.update_disabled),
                    ),
                    title: Card(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            color: Colors.amber,
                            width: double.infinity,
                            child: Text(
                                'Id : ${listaDatosPersona[index].id.toString()}'),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            color: Colors.amber,
                            width: double.infinity,
                            child: Text(
                                'Nombre : ${listaDatosPersona[index].nombre}'),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            color: Colors.amber,
                            width: double.infinity,
                            child: Text(
                                'Apellido : ${listaDatosPersona[index].apellido}'),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            color: Colors.amber,
                            width: double.infinity,
                            child: Text(
                                'Direccion :${listaDatosPersona[index].direccion}'),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            color: Colors.amber,
                            width: double.infinity,
                            child: Text(
                                ' Edad : ${listaDatosPersona[index].edad.toString()}'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    ],
  );
}
