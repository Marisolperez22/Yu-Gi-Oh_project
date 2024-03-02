import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/archetype.models.dart';
import '../models/card_model.dart';

class ApiProvider with ChangeNotifier {
  final url = 'db.ygoprodeck.com';
  List<CardInfo> cards = [];
  List<Archetype> archetypes = [];

  Future<void> getCards() async {
    try {
      final result = await http.get(Uri.https(url, '/api/v7/cardinfo.php'));
      final response = cardResponseFromJson(result.body);
      cards.addAll(response.data!);

      notifyListeners();
    } catch (e) {
      throw Exception('Error fetching cards: $e');
    }
  }

  Future<void> getArchetypes() async {
    try {
      final response = await http.get(Uri.https(url, '/api/v7/archetypes.php'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        archetypes =
            data.map<Archetype>((json) => Archetype.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load archetypes');
      }
    } catch (e) {
      throw Exception('Error fetching archetypes: $e');
    }
  }
}
