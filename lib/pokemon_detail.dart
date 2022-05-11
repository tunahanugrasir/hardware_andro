import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex/models/pokedex.dart';

class PokemonDetail extends StatefulWidget {
  Pokemon pokemon;

  PokemonDetail({this.pokemon});

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  PaletteGenerator paletteGenerator;
  Color baskinRenk;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    baskinRengiBul();
  }

  void baskinRengiBul() {
    Future<PaletteGenerator> fPaletGenerator =
        PaletteGenerator.fromImageProvider(NetworkImage(widget.pokemon.img));
    fPaletGenerator.then((value) {
      paletteGenerator = value;
      debugPrint(
          "secilen renk :" + paletteGenerator.dominantColor.color.toString());

      setState(() {
        baskinRenk = paletteGenerator.vibrantColor.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baskinRenk,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.pokemon.name,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return dikeyEkran(context);
        } else {
          return yatayEkran(context);
        }
      }),
    );
  }

  Widget yatayEkran(BuildContext context) {
    return Container(
      //color: Colors.lightGreenAccent,
      width: MediaQuery.of(context).size.width - 20,
      height: MediaQuery.of(context).size.height * (3 / 4),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.lightGreenAccent,
        border: Border.all(color: Colors.lightGreenAccent.shade700),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Hero(
                tag: widget.pokemon.img,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  // height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.network(
                    widget.pokemon.img,
                    fit: BoxFit.fill,
                  ),
                )),
          ),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //SizedBox(height: 50),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  Text(
                    widget.pokemon.name,
                    style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Height: " + widget.pokemon.height,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Weight: " + widget.pokemon.weight,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Types: ",
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.type
                        .map((tip) => Chip(
                            backgroundColor: Colors.deepOrangeAccent,
                            label: Text(tip)))
                        .toList(),
                  ),
                  Text(
                    "Next Evolutions: ",
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.pokemon.nextEvolution != null
                          ? widget.pokemon.nextEvolution
                              .map((evolution) => Chip(
                                  backgroundColor: Colors.deepOrangeAccent,
                                  label: Text(evolution.name)))
                              .toList()
                          : [Text("Son Hali")]),
                  Text(
                    "Weaknesses: ",
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.pokemon.weaknesses != null
                          ? widget.pokemon.weaknesses
                              .map((weaknesses) => Chip(
                                  backgroundColor: Colors.deepOrangeAccent,
                                  label: Text(weaknesses)))
                              .toList()
                          : [Text("Zayıflığı yok")]),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Stack dikeyEkran(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.9,
          top: MediaQuery.of(context).size.height * 0.1,
          left: 20,
          child: Card(
            color: Colors.lightGreenAccent,
            elevation: 7,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //SizedBox(height: 50),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                Text(
                  widget.pokemon.name,
                  style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Height: " + widget.pokemon.height,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Weight: " + widget.pokemon.weight,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Types: ",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.type
                      .map((tip) => Chip(
                          backgroundColor: Colors.deepOrangeAccent,
                          label: Text(tip)))
                      .toList(),
                ),
                Text(
                  "Next Evolutions: ",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.nextEvolution != null
                        ? widget.pokemon.nextEvolution
                            .map((evolution) => Chip(
                                backgroundColor: Colors.deepOrangeAccent,
                                label: Text(evolution.name)))
                            .toList()
                        : [Text("Son Hali")]),
                Text(
                  "Weaknesses: ",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.weaknesses != null
                        ? widget.pokemon.weaknesses
                            .map((weaknesses) => Chip(
                                backgroundColor: Colors.deepOrangeAccent,
                                label: Text(weaknesses)))
                            .toList()
                        : [Text("Zayıflığı yok")]),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
              tag: widget.pokemon.img,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.network(
                  widget.pokemon.img,
                  fit: BoxFit.contain,
                ),
              )),
        ),
      ],
    );
  }
}
