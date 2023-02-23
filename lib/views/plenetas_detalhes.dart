import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlanetasDetalhes extends StatefulWidget {
  String url;

  PlanetasDetalhes({super.key, required this.url});

  @override
  State<PlanetasDetalhes> createState() => _PlanetasDetalhes();
}

class _PlanetasDetalhes extends State<PlanetasDetalhes> {
  Planet? planet;
  @override
  void initState() {
    super.initState();
    callAPI();
  }

  Future<void> callAPI() async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.parse(widget.url),
      );
      Map<String, dynamic> decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes));
      if (decodedResponse != null) {
        setState(() {
          planet = Planet.fromMap(decodedResponse);
        });
      }
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text("Detalhes"),
      ),
      body: planet == null
          ? Center(
              child: CircularProgressIndicator(color: Colors.black),
            )
          : Container(
              color: Color.fromRGBO(234, 234, 234, 1),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 2, bottom: 2, right: 7, left: 7),
                    child: Container(
                      color: Colors.white,
                      height: 200,
                      alignment: Alignment.center,
                      child: Text(planet!.name!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 2, bottom: 2, right: 7, left: 7),
                      child: Container(
                          width: MediaQuery.of(context).size.width / 1,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text("População")),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 20,
                                    alignment: Alignment.center,
                                    child: Text(planet!.population!,
                                        softWrap: true,
                                        style: TextStyle(fontSize: 18))),
                              ),
                            ],
                          ))),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2.1,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Text("Clima")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(planet!.climate!,
                                          softWrap: true,
                                          style: TextStyle(fontSize: 18))),
                                ),
                              ],
                            ))),
                    Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2.1,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Text("Terreno")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(planet!.terrain!,
                                          softWrap: true,
                                          style: TextStyle(fontSize: 18))),
                                ),
                              ],
                            ))),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2.1,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Text("Gravidade")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(planet!.gravity!,
                                          softWrap: true,
                                          style: TextStyle(fontSize: 18))),
                                ),
                              ],
                            ))),
                    Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2.1,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Text("Rotação")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(planet!.rotation_period!,
                                          softWrap: true,
                                          style: TextStyle(fontSize: 18))),
                                ),
                              ],
                            ))),
                  ]),

                ],
              ),
            ),
    );
  }
}

class Planet {
  String? name;
  String? population;
  String? climate;
  String? terrain;
  String? rotation_period;
  String? gravity;


  Planet(
      {this.name,
      this.population,
      this.climate,
      this.terrain,
      this.rotation_period,
      this.gravity,});

  factory Planet.fromMap(Map<String, dynamic> map) {
    return Planet(
        name: map['name'] ?? "",
        population: map['population'] ?? "",
        climate: map['climate'] ?? "",
        terrain: map['terrain'] ?? "",
        rotation_period: map['rotation_period'] ?? "",
        gravity: map['gravity'] ?? "",
    );
  }
}
