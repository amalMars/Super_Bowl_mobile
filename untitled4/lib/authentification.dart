
import 'package:flutter/material.dart';
import 'package:untitled4/AppUser.dart';
import 'package:untitled4/Accueil.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();




  void _login() async {
    final email = emailController.text;
    final password = passwordController.text;
    
    final user = AppUser();
    await user.initPrefs();

    await AppUser.handleSignIn(email, password);



    if(AppUser.name.isNotEmpty){

    // login success
      Navigator.of(context).pushNamedAndRemoveUntil('/home2', (Route<dynamic>route) => false);
    }
    else{
      //login refusé
     print('errrrreuuurrr');
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page d\'authentification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}

MaterialApp main() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
    routes: {
      '/home':(BuildContext context)=> AccueilPage()},
  );


}

