import 'package:flutter/material.dart';
import 'package:industrial/providers/cre_produ_prov.dart';
import 'package:industrial/providers/cre_ventana.dart';
import 'package:industrial/providers/validator_form.dart';
import 'package:industrial/screens/agregar_vent.dart';
import 'package:industrial/screens/crear_produc.dart';
import 'package:industrial/screens/home_screen.dart';
import 'package:provider/provider.dart';
 
void main() {
  runApp(
    MultiProvider(
      providers: [
       ChangeNotifierProvider(create: (_)=> TipoVentana(), child: const HomeScreen()),
       ChangeNotifierProvider(create: (_)=> CreProducProv(), child: const CrearProduccion()),
      
      
      ],
      child:
       const MyApp(),
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
      initialRoute: 'home',
      routes: {
        'home' : ( _ ) => const HomeScreen(),
        'crearProduc' : ( _ ) => const CrearProduccion(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300]
      ),
    );
  }
}