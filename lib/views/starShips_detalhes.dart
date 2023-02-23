import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:star_wars_api_test/views/starShips.dart';

class StarShipsDetalhes extends StatefulWidget {
  String url;

  StarShipsDetalhes({super.key, required this.url});

  @override
  State<StarShipsDetalhes> createState() => _StarShipsDetalhes();
}

class _StarShipsDetalhes extends State<StarShipsDetalhes> {
  Ship? ship;

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
          ship = Ship.fromMap(decodedResponse);
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
      body: ship == null
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
                      child: Text(ship!.name!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
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
                                      child: Text("Modelo")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(ship!.model!,
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
                                      child: Text("Classe")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(ship!.starship_class!,
                                          softWrap: true,
                                          style: TextStyle(fontSize: 18))),
                                ),
                              ],
                            ))),
                  ]),
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
                                    child: Text("Fabricação")),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 20,
                                    alignment: Alignment.center,
                                    child: Text(ship!.manufacturer!,
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
                                      child: Text("Velocidade Atmoferica")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(ship!.max_atmosphering_speed!,
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
                                      child: Text("HyperDrive")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(ship!.hyperdrive_rating!,
                                          softWrap: true,
                                          style: TextStyle(fontSize: 18))),
                                ),
                              ],
                            ))),
                  ]),
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
                                    child: Text("Valor")),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 20,
                                    alignment: Alignment.center,
                                    child: Text(ship!.cost_in_credits!,
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
                                      child: Text("Tamanho")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(ship!.length!,
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
                                      child: Text("Passageiros")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(ship!.passengers!,
                                          softWrap: true,
                                          style: TextStyle(fontSize: 18))),
                                ),
                              ],
                            ))),
                  ])
                ],
              ),
            ),
    );
  }
}

class Ship {
  String? name;
  String? model;
  String? starship_class;
  String? manufacturer;
  String? cost_in_credits;
  String? length;
  String? passengers;
  String? max_atmosphering_speed;
  String? hyperdrive_rating;

  Ship({
    this.name,
    this.model,
    this.starship_class,
    this.manufacturer,
    this.cost_in_credits,
    this.length,
    this.passengers,
    this.max_atmosphering_speed,
    this.hyperdrive_rating,
  });

  factory Ship.fromMap(Map<String, dynamic> map) {
    return Ship(
      name: map['name'] ?? "",
      model: map['model'] ?? "",
      starship_class: map['starship_class'] ?? "",
      manufacturer: map['manufacturer'] ?? "",
      cost_in_credits: map['cost_in_credits'] ?? "",
      length: map['length'] ?? "",
      passengers: map['passengers'] ?? "",
      max_atmosphering_speed: map['max_atmosphering_speed'] ?? "",
      hyperdrive_rating: map['hyperdrive_rating'] ?? "",
    );
  }
}
