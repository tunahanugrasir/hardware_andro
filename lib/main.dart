import 'package:flutter/material.dart';
import 'package:pokedex/pokemon_listesi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          //primarySwatch: Colors.deepOrange,
          // primaryColor: Colors.black
          ),
      home: PokemonListesi(),
    );
  }
}
