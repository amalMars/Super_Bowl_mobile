import 'package:mysql_client/mysql_client.dart';
import 'package:untitled4/AppUser.dart';

class Match {
  final int id;
  final int equipe1Id;
  final int equipe2Id;
  final DateTime heureDebut;
  final DateTime heureFin;
  final String statut;
  final int score;
  final String meteo;

  Match({
    required this.id,
    required this.equipe1Id,
    required this.equipe2Id,
    required this.heureDebut,
    required this.heureFin,
    required this.statut,
    required this.score,
    required this.meteo,
  });
}
