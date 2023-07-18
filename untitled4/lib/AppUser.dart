import 'package:mysql_client/mysql_client.dart';


class AppUser {
  // User data
  static String id_user = "";
  static String name = "";
  static String email = "";
  static String mise = "";



  // MySQL connection settings
  static const String host = '10.0.2.2';
  static const int port = 3306;
  static const String user = 'root';
  static const String password = 'root';
  static const String database = 'super_bowl';

  static late  MySQLConnection connection ;

  AppUser._init() {
    initPrefs();
  }

  initPrefs() async {
    // Initialize preferences or perform other initialization tasks
    await connectToDatabase();
  }
  Future<void> connectToDatabase() async {
    print("tcreateConnection");
     connection = await MySQLConnection.createConnection(
      host: host,
      port: port,
      userName: user,
      password: password,
      databaseName: database,
    );


    try {
      print(" try connected");
       await connection.connect();
       print("connected");
     // selectionner les matchs auxquels l'utilisateur a parié.
     /*  var res_id_match = await connection.execute(
        "SELECT match_id FROM mise where utilisateur_id = $id_user ",
          );*/
       var res = await connection.execute(
         "SELECT * FROM utilisateur  ",
       );

      print(res.numOfColumns);
      print(res.numOfRows);
      for (final row in res.rows) {
        print(row.colByName("nom"));
      }

      //await connection.close();
    } catch (e) {
      print('Error connecting to MySQL: $e');

    }

  }

  factory AppUser() {
    return _inst;
  }

  static final AppUser _inst = AppUser._init();

   static Future<void> handleSignIn(String email, String password) async {

     final user = await _getUser(email,password);


     if (user.isNotEmpty && user[0].rows.elementAt(0).colByName("mot_passe") == password) {
       // L'utilisateur est authentifié avec succès
       AppUser.id_user = user[0].rows.elementAt(0).colByName("id_utilisateur")!;
       AppUser.name = user[0].rows.elementAt(0).colByName("nom")!;
       AppUser.email = user[0].rows.elementAt(0).colByName("email")!;

    } else {
       // L'authentification a échoué
       print ("L'authentification a échoué");
         AppUser.name = "";
         AppUser.email = "";
     }
  }

  static Future<List<IResultSet>> _getUser(String email , String password) async {
    final query = "SELECT * FROM utilisateur WHERE email = '$email' AND mot_passe = '$password'  ";
    final results = await connection.execute(query );
    return results.toList();
  }


  static Future<List<IResultSet>> executeQuery(String query) async {
    final results = await connection.execute(query);
    return results.toList();
  }

}