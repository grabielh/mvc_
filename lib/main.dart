import 'package:flutter/material.dart';
import 'package:mvc_test/MVC_/clases/service/service_datos_persona.dart';
import 'package:mvc_test/MVC_/widgets/homeescrens/homeescreens.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ServiceDatosPersona>(
      create: (context) => ServiceDatosPersona(),
      child: const MaterialApp(
        title: 'MVC Test',
        home: HomeEscreens(),
      ),
    );
  }
}
