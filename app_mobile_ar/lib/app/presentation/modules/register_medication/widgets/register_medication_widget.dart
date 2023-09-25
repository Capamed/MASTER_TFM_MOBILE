import 'package:app_mobile_ar/app/domain/models/medication.dart';
import 'package:app_mobile_ar/app/domain/repositories/doctors_repository.dart';
import 'package:app_mobile_ar/app/domain/repositories/medications_repository.dart';
import 'package:app_mobile_ar/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/either.dart';
import '../../../../domain/enums/enums.dart';
import '../../../../domain/models/doctor.dart';

typedef EitherListDoctors = Either<SignInFailure, List<Doctor>>;
typedef EitherListMedications = Either<SignInFailure, List<Medication>>;

class RegisterMedicationWidget extends StatefulWidget {
  const RegisterMedicationWidget({super.key});

  @override
  State<RegisterMedicationWidget> createState() =>
      _RegisterMedicationWidgetState();
}

class _RegisterMedicationWidgetState extends State<RegisterMedicationWidget> {
  late final Future<EitherListDoctors> _futureDoctors;
  late final Future<EitherListMedications> _futureMedications;

  @override
  void initState() {
    final doctorsRepository = context.read<DoctorsRepository>();
    _futureDoctors = doctorsRepository.getDataDoctors();
    final medicationsRepository = context.read<MedicationsRepository>();
    _futureMedications = medicationsRepository.getDataMedications();
    super.initState();
  }

  String selectedItemDoctor = '1718302951001';
  int selectedItemMedication = 1;

  @override
  Widget build(BuildContext context) {
    late final List<Doctor> lstDoctors;
    late final List<Medication> lstMedications;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Doctor',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '*',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Center(
                          child: FutureBuilder<EitherListDoctors>(
                            future: _futureDoctors,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return const Text('Error al cargar opciones');
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isLeft) {
                                return const Text(
                                    'No hay opciones disponibles');
                              } else {
                                final resultServiceAsEither = snapshot.data!;
                                resultServiceAsEither.when(
                                  (p0) => null,
                                  (result) {
                                    lstDoctors = result;
                                  },
                                );
                                return DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  value: selectedItemDoctor,
                                  items: lstDoctors.map((tmp) {
                                    return DropdownMenuItem(
                                      value: tmp.identificationNumber,
                                      child: Text(tmp.nameDoctor),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedItemDoctor = value as String;
                                    });
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        'Medication',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '*',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FutureBuilder<EitherListMedications>(
                          future: _futureMedications,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return const Text('Error al cargar opciones');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isLeft) {
                              return const Text('No hay opciones disponibles');
                            } else {
                              final resultServiceAsEither = snapshot.data!;
                              resultServiceAsEither.when(
                                (p0) => null,
                                (result) {
                                  lstMedications = result;
                                },
                              );
                              return DropdownButtonFormField<int>(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                      color: Colors.blue,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                value: selectedItemMedication,
                                items: lstMedications.map((tmp) {
                                  return DropdownMenuItem(
                                    value: tmp.medicationId,
                                    child: Text(tmp.nameMedication),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedItemMedication = value as int;
                                  });
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        'Amount',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '*',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Type amount',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        'Schedule',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '*',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Type schedule by hours',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://img.freepik.com/fotos-premium/antibiotico-azitromicina-envase-botella-blanca-pastillas-dispersas-tratamientos-covid19_316889-1115.jpg?w=740',
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                minWidth: 150, // Ancho mínimo del botón
                height: 60,
                onPressed: () {},
                color: Color.fromARGB(255, 79, 160, 252),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'REGISTER',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
