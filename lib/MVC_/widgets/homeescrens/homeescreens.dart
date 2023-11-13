import 'package:flutter/material.dart';
import 'package:mvc_test/MVC_/widgets/CRUD/crud_insert/crud_insert_datospersona.dart';
import 'package:mvc_test/MVC_/widgets/CRUD/crud_search_show/registro_datospersona.dart';
import 'package:mvc_test/MVC_/widgets/CRUD/crud_update/crud_update.dart';

class HomeEscreens extends StatefulWidget {
  const HomeEscreens({super.key});

  @override
  State<HomeEscreens> createState() => _HomeEscreensState();
}

class _HomeEscreensState extends State<HomeEscreens> {
  int index = 0;
  List<Widget> indexPage = const [
    CrudInsertDatosPersona(),
    CrudSearchShowDatosPersona(),
    CrudUpdateDatosPersona()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: indexPage[index],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.add_to_photos_sharp), label: 'Insert'),
          NavigationDestination(
              icon: Icon(Icons.history), label: 'Search-Show'),
          NavigationDestination(icon: Icon(Icons.update), label: 'Update'),
        ],
        onDestinationSelected: (value) {
          setState(() {
            index = value;
          });
        },
        selectedIndex: index,
      ),
    );
  }
}
