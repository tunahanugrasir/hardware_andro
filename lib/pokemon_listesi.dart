import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/pokemon_detail.dart';

import 'models/pokedex.dart';

class PokemonListesi extends StatefulWidget {
  @override
  _PokemonListesiState createState() => _PokemonListesiState();
}

class _PokemonListesiState extends State<PokemonListesi> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  Pokedex pokedex; //önce Pokedex sınıfının olduğunu bildiğimiz için bunu yazdık
  Future<Pokedex> veri;

  Future<Pokedex> pokemonlariGetir() async {
    var response = await http.get(
        url); //url den değerleri getirmek için ve işlem bitene kadar beklemesi için bu methodu kullandık
    var decodedJson = json.decode(
        response.body); //gelen nesneyi(cevabı) json objesine dönüştürdük
    pokedex = Pokedex.fromJson(
        decodedJson); //pokedexin içinde pokemon listesi olan bir nesneye dönüştürdük.
    return pokedex;
  }

  @override
  void initState() {
    // TODO: implement initState //VERİYİ BİR KERE ALDIK VE TEKRAR TEKRAR BİLGİ ALIP GELMESİNİ ENGELLEYEREK PERFORMANSI ARTTIRDIK
    super.initState();
    veri = pokemonlariGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Pokedex"),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return FutureBuilder(
              future: veri,
              builder: (context, AsyncSnapshot<Pokedex> gelenPokedex) {
                if (gelenPokedex.connectionState == ConnectionState.waiting) {
                  // ignore: missing_return
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (gelenPokedex.connectionState ==
                    ConnectionState.done) {
                  /*          return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Text(gelenPokedex.data.pokemon[index].name);
                  });
                   //Bir satırda en fazla kaç eleman olacağını seçtik
             */
                  return GridView.count(
                    crossAxisCount: 2,
                    children: gelenPokedex.data.pokemon.map((poke) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PokemonDetail(
                                    pokemon: poke,
                                  )));
                        },
                        child: Hero(
                            tag: poke.img,
                            child: Card(
                              elevation: 7,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    // height: MediaQuery.of(context).size.height*0.50,
                                    //width: MediaQuery.of(context).size.width*0.50,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: "assets/loading2.gif",
                                      image: poke.img,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    poke.name,
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )),
                      );
                    }).toList(),
                  );
                } else
                  return Text("Bağlanılamadı");
              },
            );
          } else {
            return FutureBuilder(
              future: veri,
              builder: (context, AsyncSnapshot<Pokedex> gelenPokedex) {
                if (gelenPokedex.connectionState == ConnectionState.waiting) {
                  // ignore: missing_return
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (gelenPokedex.connectionState ==
                    ConnectionState.done) {
                  /*          return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Text(gelenPokedex.data.pokemon[index].name);
                  });
                   //Bir satırda en fazla kaç eleman olacağını seçtik
             */
                  return GridView.extent(
                    maxCrossAxisExtent: 300,
                    children: gelenPokedex.data.pokemon.map((poke) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PokemonDetail(
                                    pokemon: poke,
                                  )));
                        },
                        child: Hero(
                            tag: poke.img,
                            child: Card(
                              elevation: 7,
                              child: Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      // height: MediaQuery.of(context).size.height*0.50,
                                      //width: MediaQuery.of(context).size.width*0.50,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: FadeInImage.assetNetwork(
                                        placeholder: "assets/loading2.gif",
                                        image: poke.img,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      poke.name,
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      );
                    }).toList(),
                  );
                } else
                  return Text("Bağlanılamadı");
              },
            );
          }
        },
      ), //buradaki future; geriye future döndüren bir method bekliyor
    );
  }
}
