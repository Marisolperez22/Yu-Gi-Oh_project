import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/archetype.models.dart';

class ArchetypesScreen extends StatefulWidget {
  @override
  ArchetypesScreenState createState() => ArchetypesScreenState();
}

class ArchetypesScreenState extends State<ArchetypesScreen> {
  late Future<List<Archetype>> _archetypesFuture;

  @override
  void initState() {
    super.initState();
    _archetypesFuture = getArchetypes();
  }

  Future<List<Archetype>> getArchetypes() async {
    final url = 'db.ygoprodeck.com';
    final response = await http.get(Uri.https(url, '/api/v7/archetypes.php'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      return responseData.map((data) => Archetype.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arquetipos'),
      ),
      body: FutureBuilder<List<Archetype>>(
        future: _archetypesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Archetype>? archetypes = snapshot.data;
            return ListView.builder(
              itemCount: archetypes?.length ?? 0,
              itemBuilder: (context, index) {
                final archetype = archetypes![index];
                return ListTile(
                  title: Text(archetype.archetypeName),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Detalle del Arquetipo'),
                        content: Text(
                            'Seleccionaste el arquetipo: ${archetype.archetypeName}'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cerrar'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
