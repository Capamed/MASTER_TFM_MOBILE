import 'package:flutter/material.dart';

import '../../../routes/routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.identificationNumber});

  final String identificationNumber;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        elevation: 0,
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 34, 141, 228),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text('HOME')],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(70.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Builder(
                        builder: (context) {
                          return MaterialButton(
                            onPressed: () {
                              _goToRegisterMedication(context);
                            },
                            color: Colors.white.withOpacity(0.7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.medication,
                                    color: Color.fromARGB(255, 133, 129, 129),
                                    size: 35,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'REGISTER \n MEDICATION',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: MaterialButton(
                        onPressed: () {},
                        color: Colors.white.withOpacity(0.7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.fact_check_rounded,
                                color: Color.fromARGB(255, 133, 129, 129),
                                size: 35,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'SHOW \n REGISTERS',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: MaterialButton(
                        onPressed: () {},
                        color: Colors.white.withOpacity(0.7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.camera_alt_rounded,
                                 color: Color.fromARGB(255, 133, 129, 129),
                                 size: 35,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'SCAN \n MEDICATION',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _goToRegisterMedication(BuildContext context){
    Navigator.pushReplacementNamed(context, Routes.REGISTER_MEDICATION, arguments: '1718302951');
  }
}
