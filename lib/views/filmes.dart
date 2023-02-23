import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:romanice/romanice.dart';

import 'filmes_detalhes.dart';

class Filmes extends StatefulWidget {
  const Filmes({super.key,});

  @override
  State<Filmes> createState() => _Filmes();
}

class _Filmes extends State<Filmes> {
  List<Film> films = [];

  @override
  void initState() {
    super.initState();
    callAPI();
  }

  Future<void> callAPI() async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.https('swapi.dev', 'api/films'),
      );
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes))['results'] as List;
      if (decodedResponse != null) {
        setState(() {
          films = decodedResponse.map((e) => Film.fromMap(e)).toList();
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
          actions: [
            PopupMenuButton(
                icon: Icon(Icons.search_outlined),
                itemBuilder: (context) => [PopupMenuItem(child: TextField())])
          ],
          title: Text("Filmes"),
        ),
        body: films.isEmpty
            ? Center(
                child: CircularProgressIndicator(color: Colors.black),
              )
            : ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    children: [
                      ...criarFilm(films),
                    ],
                  )
                ],
              ));
  }

  List<Widget> criarFilm(List<Film> filmes) {
    final ToRoman standardToRoman = ToRoman();

    return filmes
        .map((film) => InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilmesDetalhes(
                      url: film.url == null ? "" : film.url!,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(3),
                                ),
                                Text(
                                  "Episode " +
                                      standardToRoman(film.episode_id!),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  film.title!,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
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
            ))
        .toList();
  }
}

class Film {
  String? title;
  int? episode_id;
  String? url;

  Film({this.title, this.episode_id , this.url});

  factory Film.fromMap(Map<String, dynamic> map) {
    return Film(
      title: map['title'] ?? "",
      episode_id: map['episode_id'] ?? "",
      url: map['url'] ?? "",
    );
  }
}
