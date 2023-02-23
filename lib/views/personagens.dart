import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:star_wars_api_test/views/personagens_detalhes.dart';

class Personagens extends StatefulWidget{
  const Personagens({super.key,});

  @override
  State<Personagens> createState() => _Personagens();

}

class _Personagens extends State<Personagens>{

  List<People> peoples = [];

  @override
  void initState() {
    super.initState();
    callAPI();
  }
  Future<void> callAPI() async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.https('swapi.dev', 'api/people'),
      );
      var decodedResponse =
      jsonDecode(utf8.decode(response.bodyBytes))['results'] as List;
      if (decodedResponse != null) {
        setState(() {
          peoples = decodedResponse.map((e) => People.fromMap(e)).toList();
        });
      }
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          Icon(Icons.search)
        ],
        title: Text("personagens"),),

      body: peoples.isEmpty
          ? Center(
        child: CircularProgressIndicator(color: Colors.black),
      )
          : ListView(
        children: [
          SizedBox(height: 20,),
          Wrap(
            children: [
              ...criarPesonagem(peoples),
            ],
          ),
        ],
      ),
    );
  }
  List<Widget> criarPesonagem(List<People> pessoas) {

    return pessoas
        .map((people) => InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonagensDetalhes(
              url: people.url == null ? "" : people.url!,
            ),
          ),
        );
      },
      child: Padding(
        padding:EdgeInsets.all(6.0),
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
                        Text(people.name!,
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
    ))
        .toList();
  }
}

class People {
  String? name;
  String? url;

  People({this.name, this.url});

  factory People.fromMap(Map<String, dynamic> map) {
    return People(
      name: map['name'] ?? "",
      url: map['url'] ?? "",
    );
  }
}