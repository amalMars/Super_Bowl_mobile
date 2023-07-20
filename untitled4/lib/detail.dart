import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled4/AppUser.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:untitled4/Accueil.dart';

class MatchDetailPage extends StatefulWidget {
  final Match match;

  MatchDetailPage({required this.match});

  @override
  _MatchDetailPageState createState() => _MatchDetailPageState();
}

class _MatchDetailPageState extends State<MatchDetailPage> {
  List<Comment> comments = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    fetchComments();

    // Start a timer to refresh comments every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 5), (_) {
      fetchComments();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> fetchComments() async {
    final query =
        "SELECT * FROM commentaire WHERE match_id = ${widget.match.id}";
    final results = await AppUser.executeQuery(query);

    setState(() {
      comments =
          results[0].rows.map((row) => Comment.fromResultSetRow(row)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Match ID: ${widget.match.id}'),
            Text('Equipe 1: ${widget.match.equipe1Name}'),
            Text('Equipe 2: ${widget.match.equipe2Name}'),
            Text('heur debut: ${widget.match.heurDebut}'),
            Text('meteo: ${widget.match.meteo}'),
            Text('heur fin : ${widget.match.heurFin}'),
            Text('Status: ${widget.match.statut}'),
            Text('Score: ${widget.match.score}'),
            // Display other match details as needed

            SizedBox(height: 16),
            Text('Commentaires:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

           (comments.isEmpty? Text('pas des commentaires.'):
            Column(
            children: comments.map((comment) {
                return ListTile(
                  title: Text('User ID: ${comment.utilisateurId}'),
                  subtitle: Text(comment.commentaire),
                );
              }).toList(),
            ))
          ],
        ),
      ),
    );
  }
}

class Comment {
  final String id;
  final String utilisateurId;
  final String matchId;
  final String commentaire;

  Comment({
    required this.id,
    required this.utilisateurId,
    required this.matchId,
    required this.commentaire,
  });

  factory Comment.fromResultSetRow(ResultSetRow row) {
    return Comment(
      id: row.colByName('id_commentaire') as String,
      utilisateurId: row.colByName('utilisateur_id') as String,
      matchId: row.colByName('match_id') as String,
      commentaire: row.colByName('commentaire') as String,
    );
  }
}
