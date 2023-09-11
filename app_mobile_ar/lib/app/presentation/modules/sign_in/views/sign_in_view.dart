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
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              child: AbsorbPointer(
                absorbing: _fetching,
                child: Column(
                  children: [
                    TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (text) {
                          _username = text.trim().toLowerCase();
                        },
                        keyboardType: TextInputType.text,
                        decoration:
                            const InputDecoration(label: Text('Username')),
                        validator: (text) {
                          text = text?.trim().toLowerCase() ?? '';
                          if (text.isEmpty) {
                            return 'Invalid username';
                          }
                          return null;
                        }),
                    const SizedBox(height: 30),
                    TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (text) {
                          _password = text.replaceAll(' ', '').toLowerCase();
                        },
                        obscureText: true,
                        decoration:
                            const InputDecoration(label: Text('Password')),
                        validator: (text) {
                          text = text?.replaceAll(' ', '').toLowerCase() ?? '';
                          if (text.isEmpty) {
                            return 'Invalid password';
                          }
                          return null;
                        }),
                    const SizedBox(height: 30),
                    Builder(builder: (context) {
                      if (_fetching) {
                        return const CircularProgressIndicator();
                      }
                      return MaterialButton(
                          onPressed: () {
                            final isValid = Form.of(context)!.validate();
                            if (isValid) {
                              //codigo para conectarnose con la api para valida username
                              _submit(context);
                            }
                          },
                          child: const Text('Sign In'));
                    })
                  ],
                ),
              ),
            )),
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
