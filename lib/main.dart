import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const EarthVista());

final ThemeData theme = ThemeData();

class EarthVista extends StatelessWidget {
  const EarthVista({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
          ),),
        
          
      home: const HomeScreen(
        title: 'Earth Vista',
      ),
    );
  }
}
