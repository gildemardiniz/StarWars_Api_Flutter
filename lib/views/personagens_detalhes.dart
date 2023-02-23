import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PersonagensDetalhes extends StatefulWidget {
  String url;

  PersonagensDetalhes({super.key, required this.url});

  @override
  State<PersonagensDetalhes> createState() => _PersonagensDetalhes();
}

class _PersonagensDetalhes extends State<PersonagensDetalhes> {
  People? people;

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
          people = People.fromMap(decodedResponse);
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
      body: people == null
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
                      child: Text(people!.name!,
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
                                    child: Text("Planeta Natal")),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 20,
                                    alignment: Alignment.center,
                                    child: Text('',
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
                                      child: Text("genero")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(people!.gender!,
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
                                      child: Text("Altura")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(people!.height!,
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
                                    child: Text("Especie")),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 20,
                                    alignment: Alignment.center,
                                    child: Text('',
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
                                      child: Text("Cor dos olhos")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(people!.eye_color!,
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
                                      child: Text("Cor do cabelo")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(people!.hair_color!,
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
                                    child: Text("Idade")),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 20,
                                    alignment: Alignment.center,
                                    child: Text(people!.birth_year!,
                                        softWrap: true,
                                        style: TextStyle(fontSize: 18))),
                              ),
                            ],
                          ))),
                ],
              ),
            ),
    );
  }
}

class People {
  String? name;
  String? birth_year;
  String? gender;
  String? homeworld;
  String? height;
  String? hair_color;
  String? species;
  String? eye_color;

  People(
      {this.name,
      this.birth_year,
      this.gender,
      this.homeworld,
      this.height,
      this.hair_color,
      this.species,
      this.eye_color});

  factory People.fromMap(Map<String, dynamic> map) {
    return People(
        name: map['name'] ?? "",
        gender: map['gender'] ?? "",
        birth_year: map['birth_year'] ?? "",
        homeworld: map['homeworld'] ?? "",
        height: map['height'] ?? "",
        eye_color: map['eye_color']?? "",
        hair_color: map['hair_color'] ?? "");
  }
}
