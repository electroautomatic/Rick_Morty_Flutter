// Реализация запроса к API RickMorty
import '../models/chracter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CharacterRepo {
  Future<Character> getCharacter(int page, String name) async {
    final url = "https://rickandmortyapi.com/api/character/";
    try {
      var response = await http.get(Uri.parse(url + '?page=$page&name=$name'));
      var jsonResult = json.decode(response.body);
      return Character.fromJson(jsonResult);
    } catch (e) {
      throw Exception(e.toString());
    }
    
  }
}
