import 'package:app_mobile_ar/app/domain/enums/enums.dart';
import 'package:app_mobile_ar/app/presentation/routes/routes.dart';
import 'package:app_mobile_ar/main.dart';
import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String _username = '', _password = '';
  bool _fetching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B89B0), Color(0xFF000000)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Flexible(
          child: Container(
            alignment: Alignment.center,
            child: Center(
              child: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Form(
                      child: AbsorbPointer(
                        absorbing: _fetching,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(30)),
                          width: double.infinity,
                          height: 500,
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            children: [
                              const Center(
                                child: Icon(
                                  Icons.account_circle_outlined,
                                  size: 55,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              const Text(
                                'Sign in with',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Icon(
                                      Icons.reddit_rounded,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 25.0, left: 25.0),
                                      child: Icon(
                                        Icons.android_rounded,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Icon(
                                      Icons.facebook,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              const Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: Colors.white,
                                      height: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      "or",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Colors.white,
                                      height: 2,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15.0),
                              Flexible(
                                child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onChanged: (text) {
                                      _username = text.trim().toLowerCase();
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.black.withOpacity(0.2),
                                      label: const Text(
                                        'USERNAME',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0)),
                                      ),
                                    ),
                                    validator: (text) {
                                      text = text?.trim().toLowerCase() ?? '';
                                      if (text.isEmpty) {
                                        return 'Invalid username';
                                      }
                                      return null;
                                    }),
                              ),
                              const SizedBox(height: 30),
                              Flexible(
                                child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onChanged: (text) {
                                      _password = text
                                          .replaceAll(' ', '')
                                          .toLowerCase();
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.black.withOpacity(0.2),
                                      label: const Text(
                                        'PASSWORD',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0)),
                                      ),
                                    ),
                                    validator: (text) {
                                      text = text
                                              ?.replaceAll(' ', '')
                                              .toLowerCase() ??
                                          '';
                                      if (text.isEmpty) {
                                        return 'Invalid password';
                                      }
                                      return null;
                                    }),
                              ),
                              const SizedBox(height: 30),
                              Builder(builder: (context) {
                                if (_fetching) {
                                  return const CircularProgressIndicator();
                                }
                                return MaterialButton(
                                  minWidth: 150, // Ancho mínimo del botón
                                  height: 60,
                                  onPressed: () {
                                    final isValid =
                                        Form.of(context)!.validate();
                                    if (isValid) {
                                      //codigo para conectarnose con la api para valida username
                                      _submit(context);
                                    }
                                  },
                                  color: Colors.black.withOpacity(
                                      0.2), // Color de fondo del botón
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20), // Personaliza el radio de las esquinas
                                    // Puedes personalizar más propiedades del borde si es necesario
                                  ),
                                  child: const Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    setState(() {
      _fetching = true;
    });

    final result = await Injector.of(context)
        .authenticationRepository
        .signIn(_username, _password);

    if (!mounted) {
      return;
    }

    result.when((failure) {
      setState(() {
        _fetching = false;
      });
      final message = {
        SignInFailure.notFound: 'Not Found',
        SignInFailure.unauthorized: 'Invalid Password',
        SignInFailure.unknown: 'Internal Error',
      }[failure];
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message!)));
    }, (user) {
      Navigator.pushReplacementNamed(context, Routes.HOME);
    });
  }
}
