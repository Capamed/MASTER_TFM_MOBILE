import 'package:flutter/material.dart';

class DoctorsList extends StatefulWidget {
  const DoctorsList({super.key});

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
   final List<String> opciones = ['Opción 1', 'Opción 2', 'Opción 3'];

  String opcionSeleccionada = 'Opción 1';

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Selecciona una opción:'),
                DropdownButton<String>(
                  value: opcionSeleccionada,
                  onChanged: (String? nuevaOpcion) {
                    if (nuevaOpcion != null) {
                      setState(() {
                        opcionSeleccionada = nuevaOpcion;
                      });
                    }
                  },
                  items: opciones.map<DropdownMenuItem<String>>((String opcion) {
                    return DropdownMenuItem<String>(
                      value: opcion,
                      child: Text(opcion),
                    );
                  }).toList(),
                ),
                Text('Opción seleccionada: $opcionSeleccionada'),
              ],
            ),
          ),
        ),
    );
  }
}