import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:star_wars_api_test/views/plenetas_detalhes.dart';

class Planetas extends StatefulWidget{
  const Planetas({super.key,});

  @override
  State<Planetas> createState() => _Planetas();

}

class _Planetas extends State<Planetas>{
  List<Planet> planets = [];

  @override
  void initState() {
    super.initState();
    callAPI();
  }
  Future<void> callAPI() async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.https('swapi.dev', 'api/planets'),
      );
      var decodedResponse =
      jsonDecode(utf8.decode(response.bodyBytes))['results'] as List;
      if (decodedResponse != null) {
        setState(() {
          planets = decodedResponse.map((e) => Planet.fromMap(e)).toList();
        });
      }
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          Icon(Icons.search)
        ],
        title: Text("Planetas"),),
      body: planets.isEmpty
          ? Center(
        child: CircularProgressIndicator(color: Colors.black),
      )
          :
      ListView(
        children: [
          SizedBox(height: 20,),
          Wrap(
            children: [
              ...criarPlaneta(planets),
            ],
          ),
        ],
      ),
    );
  }
  List<Widget> criarPlaneta(List<Planet> Planetas) {
    return Planetas.map((planet) => InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlanetasDetalhes(
              url: planet.url == null ? "" : planet.url!,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Colors.white54,
              ),
              padding: EdgeInsets.all(3),
              width: 180,
              height: 280,
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://lumiere-a.akamaihd.net/v1/images/og-generic_02031d2b.png'),
                          fit: BoxFit.fill),
                    ),
                    width: 170,
                    height: 200,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    width: 170,
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(3),
                        ),
                        Text(planet.name!,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    )).toList();
  }
}
class Planet {
  String? name;
  String? url;

  Planet({this.name, this.url});

  factory Planet.fromMap(Map<String, dynamic> map) {
    return Planet(
      name: map['name'] ?? "",
      url: map['url'] ?? "",
    );
  }
}