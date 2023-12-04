import 'package:atelier4_mohamedtaha_elasri_iir5g7/liste_produits.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginEcran extends StatelessWidget {
  @override
Widget build(BuildContext context) {

  return StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if (!snapshot.hasData ) {
        return SignInScreen();
      }
      return ListeProduits();
    },
  );
}
}
/* @override
Widget build(BuildContext context) {
  return StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.hasData && snapshot.data != null) {
        User? user = snapshot.data;
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Email: ${user!.email}'),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: Text('Se déconnecter'),
              ),
            ],
          ),
        );
      } else {
         return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Mot de passe'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {    },
                child: Text('Se connecter'),
              ),
            ],
          ),
        );
      
      }
    },
  );
}
} */