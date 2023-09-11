import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '', password = '';
  bool? userIsValid;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(29.0),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (text) {
                        username = text.trim().toLowerCase();
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
                        password = text.replaceAll(' ', '').toLowerCase();
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
                    return MaterialButton(
                        onPressed: () {
                          final isValid = Form.of(context)!.validate();
                          if (isValid) {
                            //codigo para conectarnose con la api para valida username
                          }
                        },
                        child: const Text('Sign In'));
                  })
                ],
              ),
            )),
      ),
    );
  }
}
