import 'package:flutter/material.dart';
import 'package:industrial/providers/cre_produ_prov.dart';
import 'package:industrial/providers/cre_ventana.dart';
import 'package:industrial/providers/validator_form.dart';
import 'package:industrial/screens/agregar_vent.dart';
import 'package:industrial/screens/check_auth_screen.dart';
import 'package:industrial/screens/crear_produc.dart';
import 'package:industrial/screens/home_screen.dart';
import 'package:industrial/screens/login_screen.dart';
import 'package:industrial/services/auth_service.dart';
import 'package:industrial/services/notifications_service.dart';
import 'package:industrial/services/products_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => TipoVentana(), child: const HomeScreen()),
        ChangeNotifierProvider(
            create: (_) => CreProducProv(), child: const CrearProduccion()),
        ChangeNotifierProvider(create: (_) => AuthService()),
         ChangeNotifierProvider(create: ( _ ) => ProductsService() ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'checking',
      routes: {
        'checking': ( _ ) => CheckAuthScreen(),
        'home': (_) => const HomeScreen(),
        'crearProduc': (_) => const CrearProduccion(),
        'login': (_) => LoginScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white),
    );
  }
}
