import 'package:flutter/material.dart';
import 'package:app_mobile_ar/main.dart';
import '../../../routes/routes.dart';
import 'package:app_mobile_ar/app/domain/models/medication.dart';
import 'package:app_mobile_ar/app/domain/repositories/doctors_repository.dart';
import 'package:app_mobile_ar/app/domain/repositories/medications_repository.dart';
import 'package:provider/provider.dart';

import '../../../../domain/either.dart';
import '../../../../domain/enums/enums.dart';
import '../../../../domain/models/doctor.dart';

typedef EitherListDoctors = Either<SignInFailure, List<Doctor>>;
typedef EitherListMedications = Either<SignInFailure, List<Medication>>;

class RegisterMedicationView extends StatefulWidget {
  const RegisterMedicationView({super.key, required this.identificationNumber});

  final String identificationNumber;

  @override
  State<RegisterMedicationView> createState() => _RegisterMedicationViewState();
}

class _RegisterMedicationViewState extends State<RegisterMedicationView> {
  late final Future<EitherListDoctors> _futureDoctors;
  late final Future<EitherListMedications> _futureMedications;
  late String pathMedication;
  String selectedItemDoctor = '1718302951001';
  int selectedItemMedication = 1;
  bool _fetching = false;
  String _amount = '', _schedule = '', _observation = '';

  @override
  void initState() {
    final doctorsRepository = context.read<DoctorsRepository>();
    _futureDoctors = doctorsRepository.getDataDoctors();
    final medicationsRepository = context.read<MedicationsRepository>();
    _futureMedications = medicationsRepository.getDataMedications();
    super.initState();
    pathMedication =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvCAW6jW4jPwerruXO-aSX_lhsdKQmSx98AV8i19BkMJbgXFkPOe_yjQKYIgKro5QwHvc&usqp=CAU';
  }

  @override
  Widget build(BuildContext context) {
    late final List<Doctor> lstDoctors;
    late final List<Medication> lstMedications;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(
                'Register medication:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: AbsorbPointer(
                  absorbing: _fetching,
                  child: Column(
                    children: [
                      Card(
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
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
                                            return const Text(
                                                'Error al cargar opciones');
                                          } else if (!snapshot.hasData ||
                                              snapshot.data!.isLeft) {
                                            return const Text(
                                                'No hay opciones disponibles');
                                          } else {
                                            final resultServiceAsEither =
                                                snapshot.data!;
                                            resultServiceAsEither.when(
                                              (p0) => null,
                                              (result) {
                                                lstDoctors = result;
                                              },
                                            );
                                            return DropdownButtonFormField<
                                                String>(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderSide: const BorderSide(
                                                    color: Colors.blue,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              value: selectedItemDoctor,
                                              items: lstDoctors.map((tmp) {
                                                return DropdownMenuItem(
                                                  value:
                                                      tmp.identificationNumber,
                                                  child: Text(tmp.nameDoctor),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedItemDoctor =
                                                      value as String;
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
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
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
                                          return const Text(
                                              'Error al cargar opciones');
                                        } else if (!snapshot.hasData ||
                                            snapshot.data!.isLeft) {
                                          return const Text(
                                              'No hay opciones disponibles');
                                        } else {
                                          final resultServiceAsEither =
                                              snapshot.data!;
                                          resultServiceAsEither.when(
                                            (p0) => null,
                                            (result) {
                                              lstMedications = result;
                                            },
                                          );
                                          return DropdownButtonFormField<int>(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
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
                                                selectedItemMedication =
                                                    value as int;
                                                pathMedication = lstMedications
                                                    .firstWhere((medication) =>
                                                        medication
                                                            .medicationId ==
                                                        selectedItemMedication)
                                                    .photo;
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
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      onChanged: (text) {
                                        _amount = text.trim().toLowerCase();
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        hintText: 'Type amount',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                        ),
                                      ),
                                      validator: (text) {
                                        text = text?.trim().toLowerCase() ?? '';
                                        if (text.isEmpty) {
                                          return 'Invalid amount';
                                        }
                                        return null;
                                      },
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
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      onChanged: (text) {
                                        _schedule = text.trim().toLowerCase();
                                      },
                                      decoration: const InputDecoration(
                                        hintText: 'Type schedule by hours',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                        ),
                                      ),
                                      validator: (text) {
                                        text = text?.trim().toLowerCase() ?? '';
                                        if (text.isEmpty) {
                                          return 'Invalid schedule';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: TextFormField(
                                      maxLines: 2,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      onChanged: (text) {
                                        _observation =
                                            text.trim().toLowerCase();
                                      },
                                      decoration: const InputDecoration(
                                        label: Text('Type your observation'),
                                        hintText: 'Type your observation',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                        ),
                                      ),
                                      validator: (text) {
                                        text = text?.trim().toLowerCase() ?? '';
                                        if (text.isEmpty) {
                                          return 'Invalid observation';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Photo: The image load when you choose the medication',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 110, 109, 109)),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(
                                    pathMedication,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Builder(
                            builder: (context) {
                              if (_fetching) {
                                return const CircularProgressIndicator();
                              }
                              return MaterialButton(
                                minWidth: 120,
                                height: 40,
                                onPressed: () {
                                  final isValid = Form.of(context)!.validate();
                                  if (isValid) {
                                    _createRegister(context);
                                  }
                                },
                                color: const Color.fromARGB(255, 79, 160, 252),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'REGISTER',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future<void> _createRegister(BuildContext context) async {
    setState(() {
      _fetching = true;
    });
    Navigator.pushReplacementNamed(context, Routes.HOME);
  }
}
