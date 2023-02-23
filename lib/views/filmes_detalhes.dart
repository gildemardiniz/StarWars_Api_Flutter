import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:romanice/romanice.dart';

class FilmesDetalhes extends StatefulWidget {
  String url;

  FilmesDetalhes({super.key, required this.url});

  @override
  State<FilmesDetalhes> createState() => _FilmesDetalhes();
}

class _FilmesDetalhes extends State<FilmesDetalhes> {
  Film? film;

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
          film = Film.fromMap(decodedResponse);
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
      body: film == null
          ? Center(
              child: CircularProgressIndicator(color: Colors.black),
            )
          : Container(
              color: Color.fromRGBO(234, 234, 234, 1),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2,bottom: 2, right: 7,left: 7),
                    child: Container(
                      color: Colors.white,
                      height: 200,
                      alignment: Alignment.center,
                      child: Text(film!.title!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 2,bottom: 2, right: 7,left: 7),
                      child: Container(
                          width: MediaQuery.of(context).size.width/1,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text("Lançamento")),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 20,
                                    alignment: Alignment.center,
                                    child: Text(film!.release_date!,
                                        softWrap: true,
                                        style: TextStyle(fontSize: 18))),
                              ),
                            ],
                          ))),
                  Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width/2.1,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Text("Diretor")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 100,
                                      alignment: Alignment.center,
                                      child: Text(film!.director!,
                                          softWrap: true,
                                          style: TextStyle(fontSize: 18))),
                                ),
                              ],
                            ))),
                    Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width/2.1,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Text("produtor")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 100,
                                      alignment: Alignment.center,
                                      child: Text(film!.producer!,
                                          softWrap: true,
                                          style: TextStyle(fontSize: 18))),
                                ),
                              ],
                            ))),
                  ]),

                  Padding(
                      padding: const EdgeInsets.only(top: 2,bottom: 2, right: 7,left: 7),
                      child: Container(
                          width: MediaQuery.of(context).size.width/1,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text("Abertura")),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text(film!.opening_crawl!,
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

class Film {
  String? title;
  int? episode_id;
  String? director;
  String? opening_crawl;
  String? producer;
  String? release_date;

  Film(
      {this.title,
      this.episode_id,
      this.director,
      this.opening_crawl,
      this.producer,
      this.release_date});

  factory Film.fromMap(Map<String, dynamic> map) {
    return Film(
        title: map['title'] ?? "",
        episode_id: map['episode_id'] ?? "",
        opening_crawl: map['opening_crawl'] ?? "",
        director: map['director'] ?? "",
        producer: map['producer'] ?? "",
        release_date: map['release_date'] ?? "");
  }
}
