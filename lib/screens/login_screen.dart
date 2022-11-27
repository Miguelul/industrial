import 'package:flutter/material.dart';
import 'package:industrial/screens/register_screen.dart';

import 'package:provider/provider.dart';

import '../providers/login_form_provider.dart';
import '../services/auth_service.dart';
import '../services/notifications_service.dart';
import '../ui/input_decorations.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 50),
          Column(
            children: [
              const SizedBox(height: 10),
              const Text('Iniciar Sesión', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color.fromARGB(255, 116, 113, 113)
              )),
              const SizedBox(height: 30),
              ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(), child: _LoginForm())
            ],
          ),
          const SizedBox(height: 20),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return FadeTransition(
                        opacity: animation1,
                        child: RegisterScreen(),
                      );
                    },
                  ),
                );
              },
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder())),
              child: const Text(
                'Crear una nueva cuenta',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              )),
          const SizedBox(height: 50),
        ],
      ),
    ));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Form(
          key: loginForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'john.doe@gmail.com',
                    labelText: 'Correo electrónico',
                    prefixIcon: Icons.account_box),
                onChanged: (value) => loginForm.email = value,
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = new RegExp(pattern);
    
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'El valor ingresado no luce como un correo';
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '*****',
                    labelText: 'Contraseña',
                    prefixIcon: Icons.lock_outline),
                onChanged: (value) => loginForm.password = value,
                validator: (value) {
                  return (value != null && value.length >= 6)
                      ? null
                      : 'La contraseña debe de ser de 6 caracteres';
                },
              ),
              const SizedBox(height: 30),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Colors.deepPurple,
                  onPressed: loginForm.isLoading
                      ? null
                      : () async {
                          FocusScope.of(context).unfocus();
                          final authService =
                              Provider.of<AuthService>(context, listen: false);
    
                          if (!loginForm.isValidForm()) return;
    
                          loginForm.isLoading = true;
    
                          // TODO: validar si el login es correcto
                          final String? errorMessage = await authService.login(
                              loginForm.email, loginForm.password);
    
                          if (errorMessage == null) {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) {
                                  return FadeTransition(
                                    opacity: animation1,
                                    child: const HomeScreen(),
                                  );
                                },
                              ),
                            );
                          } else {
                            // TODO: mostrar error en pantalla
                            // print( errorMessage );
                            NotificationsService.showSnackbar(errorMessage);
                            loginForm.isLoading = false;
                          }
                        },
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      child: Text(
                        loginForm.isLoading ? 'Espere' : 'Ingresar',
                        style: const TextStyle(color: Colors.white),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
