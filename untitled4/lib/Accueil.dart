import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:untitled4/AppUser.dart';
import 'package:mysql_client/mysql_client.dart';



class AccueilPage extends StatefulWidget {
  @override
  _AccueilPageState createState() => _AccueilPageState();
}
class _AccueilPageState extends State<AccueilPage> {
  List<Match> matches = [];



  @override
  void initState() {
    super.initState();
    loadMatches();

  }

  Future<void> loadMatches() async {
    final user_id = AppUser.id_user;
    final query = "SELECT * FROM matchs m , mise  INNER JOIN mise ON m.id_match = mise.match_id WHERE mise.utilisateur_id = $user_id ";
    final results = await AppUser.executeQuery(query);

    setState(() {
      matches = results[0].rows.map((row) => Match.fromResultSetRow(row)).toList();
      matches.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue dans votre page d\'Accueil'),
      ),
      body: ListView.builder(
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];
          return ListTile(
            title: Text('Match ID: ${match.id}'),
            subtitle: Text('Equipe 1: ${match.equipe1Id}, Equipe 2: ${match.equipe2Id}'),
            // Display other match details as needed
          );
        },
      ),
    );
  }
}

class Match {
  final String id;
  final String equipe1Id;
  final String equipe2Id;
  // Add other properties as needed

  Match({
    required this.id,
    required this.equipe1Id,
    required this.equipe2Id,
    // Initialize other properties as needed
  });

  factory Match.fromResultSetRow(ResultSetRow row) {
    return Match(
      id: row.colByName('id_match') as String,
      equipe1Id: row.colByName('equipe1_id') as String,
      equipe2Id: row.colByName('equipe2_id') as String,
      // Initialize other properties from the row as needed
    );
  }

}