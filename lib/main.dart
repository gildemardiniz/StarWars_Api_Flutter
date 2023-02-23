import 'package:flutter/material.dart';
import 'package:star_wars_api_test/views/filmes.dart';
import 'package:star_wars_api_test/views/home.dart';
import 'package:star_wars_api_test/views/personagens.dart';
import 'package:star_wars_api_test/views/planetas.dart';
import 'package:star_wars_api_test/views/starShips.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars',
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _indiceAtual = 2;
  int _indiceHome = 0;

  final List<Widget> _telas = [
    Filmes(),
    Personagens(),
    Home(),
    StarShips(),
    Planetas(),
  ];

  @override
  void initState() {

    super.initState();

    _indiceHome = 2;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _indiceHome == 0 ?_telas[_indiceAtual]:_telas[_indiceHome],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _indiceAtual,
        onTap: onTabTapped,
        items: const [

          BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: "Filmes"),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Pessoas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc_rounded),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket),
            label: "StarShips",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: "Planetas",
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          setState(() {
            _indiceHome = 2;
            _indiceAtual =2;
          });
        },
        child: Icon(Icons.home, color: Colors.black,size: 35),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void onTabTapped(int index) {
    setState(() {
     _indiceHome = 0;
      _indiceAtual = index;
    });
  }
}
