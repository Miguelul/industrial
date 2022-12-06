import 'package:flutter/material.dart';
import 'package:industrial/providers/cre_produ_prov.dart';
import 'package:industrial/providers/cre_ventana.dart';
import 'package:industrial/providers/db_provider.dart';
import 'package:industrial/screens/screens.dart';
import 'package:industrial/services/auth_service.dart';
import 'package:industrial/services/notifications_service.dart';
import 'package:industrial/services/products_service.dart';
import 'package:provider/provider.dart';

import 'models/pruduccion.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final List<ProduccionCre> creProducProv = [];
  creProducProv.addAll(await DBProvider.getProducc());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => TipoVentana(), child: const HomeScreen()),
        ChangeNotifierProvider(
            create: (_) => CreProducProv(creProTem: creProducProv),
            child: const HomeScreen()),
        // ChangeNotifierProvider(
        //     create: (context) => CreProducProv(), child: AfregarVentanas()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ProductsService()),
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
        'checking': (_) => const CheckAuthScreen(),
        'home': (_) => const HomeScreen(),
        'crearProduc': (_) => const CrearProduccion(),
        'login': (_) => const LoginScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          //  primarySwatch: Colors.blue,

          primaryColor: const Color.fromARGB(255, 39, 149, 176)
          //  CupertinoColors.activeBlue
          ),
    );
  }
}
