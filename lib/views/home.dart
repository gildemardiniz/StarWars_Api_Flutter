import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 130,
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/Star_Wars_Logo.svg/694px-Star_Wars_Logo.svg.png',
            width: 120,
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Seja bem vindo!",
                  style:
                  GoogleFonts.aclonica(fontSize: 30,color: Colors.black,),
                ),
                SizedBox(height: 20,),
                Text("Jovem Padawan",style:
                GoogleFonts.aclonica(fontSize: 20,color: Colors.black,),
                ),
              ],
            )
          ],
        ));
  }
}
