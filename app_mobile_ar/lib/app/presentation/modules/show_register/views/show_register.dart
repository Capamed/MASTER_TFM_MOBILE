import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/either.dart';
import '../../../../domain/enums/enums.dart';
import '../../../../domain/models/consultation.dart';
import '../../../../domain/repositories/consultations_repository.dart';
import '../../../routes/routes.dart';

typedef EitherListConsultations = Either<SignInFailure, List<Consultation>>;
typedef EitherConsultation = Either<SignInFailure, Consultation>;
typedef EitherConsultationDelete = Either<SignInFailure, String>;
typedef EitherConsultationUpdate = Either<SignInFailure, int>;

class ShowRegistersView extends StatefulWidget {
  const ShowRegistersView({super.key, required this.identificationNumber});

  final String identificationNumber;

  @override
  State<ShowRegistersView> createState() => _ShowRegistersViewState();
}

class _ShowRegistersViewState extends State<ShowRegistersView> {
  late final Future<EitherListConsultations> _futureConsultations;
  List<Consultation> lstConsultations = [];
  bool _fetching = false;
  bool _confirm = false;
  late final String _identificationNumber = widget.identificationNumber;

  @override
  void initState() {
    super.initState();
    _loadDataListConsultations();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ListView.builder(
          itemCount: lstConsultations.length,
          itemBuilder: (context, index) {
            final consultation = lstConsultations[index];

            TextEditingController doctorNameController =
                TextEditingController(text: consultation.doctor.nameDoctor);
            TextEditingController medicationNameController =
                TextEditingController(
                    text: consultation.medication.nameMedication);
            TextEditingController amountController =
                TextEditingController(text: consultation.medication.amount);
            TextEditingController scheduleController =
                TextEditingController(text: consultation.schedule.toString());
            TextEditingController observationController =
                TextEditingController(text: consultation.observation);

            return Card(
              elevation: 4,
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Doctor:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            enabled: false,
                            controller: doctorNameController,
                            decoration: const InputDecoration(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Medication:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            enabled: false,
                            controller: medicationNameController,
                            decoration: const InputDecoration(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Amount:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            enabled: false,
                            controller: amountController,
                            decoration: const InputDecoration(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Schedule:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: scheduleController,
                            decoration: const InputDecoration(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Observation:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            maxLines: 2,
                            controller: observationController,
                            decoration: const InputDecoration(
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
                    GestureDetector(
                      child: ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              if (_fetching) {
                                const CircularProgressIndicator();
                              }
                              _updateDataListConsultations(
                                  scheduleController,
                                  observationController,
                                  consultation.consultationId);
                              if (_confirm) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Confirmation"),
                                      content: const Text(
                                          "¿Are you sure you want to exit?"),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text("Cancel"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text("Accept"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.pushReplacementNamed(
                                                context, Routes.HOME,
                                                arguments:
                                                    _identificationNumber);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            color: Colors.blue,
                            iconSize: 40.0,
                          ),
                          IconButton(
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () {
                              if (_fetching) {
                                const CircularProgressIndicator();
                              }
                              _deleteDataListConsultations(
                                  consultation.consultationId, index);
                            },
                            color: Colors.red,
                            iconSize: 50.0,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _loadDataListConsultations() async {
    final EitherListConsultations futureConsultations;
    final consultationsRepository = context.read<ConsultationsRepository>();
    futureConsultations = await consultationsRepository
        .getDataConsultations(widget.identificationNumber);
    futureConsultations.when(
      (failure) {
        final message = {
          SignInFailure.notFound: 'Not Found',
          SignInFailure.unauthorized: 'Invalid Password',
          SignInFailure.unknown: 'Internal Error',
        }[failure];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message!)));
      },
      (result) {
        setState(() {
          lstConsultations = result;
        });
      },
    );
  }

  Future<void> _updateDataListConsultations(TextEditingController schedule,
      TextEditingController observation, int consultationId) async {
    setState(() {
      _fetching = true;
    });
    final EitherConsultationUpdate futureConsultations;
    final consultationsRepository = context.read<ConsultationsRepository>();
    final objUpdateConsultation = {
      'schedule': schedule.value.text,
      'observation': observation.value.text
    };
    futureConsultations = await consultationsRepository.updateConsultationById(
        consultationId, objUpdateConsultation);
    futureConsultations.when(
      (failure) {
        final message = {
          SignInFailure.notFound: 'Not Found',
          SignInFailure.unauthorized: 'Invalid Password',
          SignInFailure.unknown: 'Internal Error',
        }[failure];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message!)));
      },
      (result) {
        setState(() {
          _fetching = false;
          _confirm = true;
        });
      },
    );
  }

  Future<void> _deleteDataListConsultations(
      int consultationId, int index) async {
    setState(() {
      _fetching = true;
    });
    final EitherConsultationDelete futureConsultations;
    final consultationsRepository = context.read<ConsultationsRepository>();
    futureConsultations =
        await consultationsRepository.deleteConsultationById(consultationId);
    futureConsultations.when(
      (failure) {
        final message = {
          SignInFailure.notFound: 'Not Found',
          SignInFailure.unauthorized: 'Invalid Password',
          SignInFailure.unknown: 'Internal Error',
        }[failure];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message!)));
      },
      (result) {
        setState(() {
          lstConsultations.removeAt(index);
        });
        Navigator.pushReplacementNamed(context, Routes.HOME,
            arguments: _identificationNumber);
        setState(() {
          _fetching = false;
        });
      },
    );
  }
}
