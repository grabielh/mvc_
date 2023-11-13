// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mvc_test/MVC_/clases/models/datos_persona.dart';
import 'package:mvc_test/MVC_/clases/service/service_datos_persona.dart';
import 'package:provider/provider.dart';

class CrudSearchShowDatosPersona extends StatefulWidget {
  const CrudSearchShowDatosPersona({Key? key}) : super(key: key);

  @override
  State<CrudSearchShowDatosPersona> createState() => _SearchSowState();
}

class _SearchSowState extends State<CrudSearchShowDatosPersona> {
  final TextEditingController _iddatos = TextEditingController();
  List<DatosPersona>? listaDatosPersona = [];

  void _updateList(List<DatosPersona>? personasEncontradas) {
    Future.microtask(() {
      setState(() {
        listaDatosPersona = personasEncontradas ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final datosPersona = Provider.of<ServiceDatosPersona>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registro',
          style: TextStyle(color: Colors.amber),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
        child: SingleChildScrollView(
          child: SizedBox(
            width: 400,
            height: 800,
            child: Column(
              children: [
                SizedBox(
                  width: 400,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 30, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 110,
                              padding: const EdgeInsets.all(5),
                              child: TextField(
                                controller: _iddatos,
                                decoration: const InputDecoration(
                                    labelText: 'ingresar Id'),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: IconButton(
                                onPressed: () async {
                                  if (_iddatos.text.isNotEmpty) {
                                    try {
                                      int id = int.parse(_iddatos.text);
                                      List<DatosPersona>? personasEncontradas =
                                          await datosPersona.buscarPorId(id);

                                      _updateList(personasEncontradas);
                                      FocusScope.of(context).unfocus();
                                    } catch (e) {
                                      print('Error al parsear el ID: $e');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Ingrese un ID válido')),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Ingrese un ID válido')),
                                    );
                                  }
                                },
                                icon: const Icon(Icons.search_outlined),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(child: _showDateList(context, datosPersona)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _showDateList(
    BuildContext context,
    ServiceDatosPersona datosPersona,
  ) {
    return Column(
      children: [
        FutureBuilder<List<DatosPersona>?>(
          future: _iddatos.text.isEmpty
              ? datosPersona.mostrarTodas()
              : datosPersona.buscarPorId(int.parse(_iddatos.text)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('No hay respuesta de la base de datos!');
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Text('No existen Datos Registrados');
            } else {
              List<DatosPersona> listaDatosPersona = snapshot.data!;
              return _buildListView(listaDatosPersona, datosPersona);
            }
          },
        ),
      ],
    );
  }

  Widget _buildListView(
      List<DatosPersona> listaDatosPersona, ServiceDatosPersona datosPersona) {
    return SizedBox(
      width: 400,
      height: 650,
      child: ListView.builder(
        itemCount: listaDatosPersona.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: IconButton(
                onPressed: () {
                  setState(() {
                    datosPersona.eliminar(context, index);
                  });
                },
                icon: const Icon(Icons.delete)),
            title: Card(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    color: Colors.amber,
                    width: double.infinity,
                    child:
                        Text('Id : ${listaDatosPersona[index].id.toString()}'),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    color: Colors.amber,
                    width: double.infinity,
                    child: Text('Nombre : ${listaDatosPersona[index].nombre}'),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    color: Colors.amber,
                    width: double.infinity,
                    child:
                        Text('Apellido : ${listaDatosPersona[index].apellido}'),
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
      ),
    );
  }
}
