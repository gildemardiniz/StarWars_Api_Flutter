import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:star_wars_api_test/views/starShips_detalhes.dart';

class StarShips extends StatefulWidget {
  const StarShips({
    super.key,
  });

  @override
  State<StarShips> createState() => _StarShipsDetalhesTela();
}

class _StarShipsDetalhesTela extends State<StarShips> {
  List<Ship> ships = [];

  @override
  void initState() {
    super.initState();
    callAPI();
  }

  Future<void> callAPI() async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.https('swapi.dev', 'api/starships'),
      );
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes))['results'] as List;
      if (decodedResponse != null) {
        setState(() {
          ships = decodedResponse.map((e) => Ship.fromMap(e)).toList();
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
        actions: [Icon(Icons.search)],
        title: Text("StarShip"),
      ),
      body: ships.isEmpty
          ? Center(
              child: CircularProgressIndicator(color: Colors.black),
            )
          : ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Wrap(
                  children: [
                    ...criarNave(ships),
                  ],
                ),
              ],
            ),
    );
  }

  List<Widget> criarNave(List<Ship> Naves) {
    return Naves.map((ship) => InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StarShipsDetalhes(
                  url: ship.url == null ? "" : ship.url!,
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
                            Text(ship.name!,
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

class Ship {
  String? name;
  String? url;

  Ship({this.name, this.url});

  factory Ship.fromMap(Map<String, dynamic> map) {
    return Ship(
      name: map['name'] ?? "",
      url: map['url'] ?? "",
    );
  }
}
