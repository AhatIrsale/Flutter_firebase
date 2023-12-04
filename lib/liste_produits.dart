import 'dart:developer';

import 'package:atelier4_mohamedtaha_elasri_iir5g7/firebase_options.dart';
import 'package:atelier4_mohamedtaha_elasri_iir5g7/produit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ListeProduits extends StatefulWidget {
  const ListeProduits({super.key});

  @override
  State<ListeProduits> createState() => _ListeProduitsState();
}

class ProduitItem extends StatelessWidget{
ProduitItem({Key? key , required this.produit}): super(key:key);
final Produit produit;
@override
Widget build(BuildContext context){
  return ListTile(
    title: Text(produit.designation),
    subtitle: Text(produit.marque),
    trailing: Text('${produit.prix} £ '),
  );
}
}

class _ListeProduitsState extends State<ListeProduits> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  void supprimerProduit(String produitId) {
    db.collection('produits').doc(produitId).delete();
  }

  void ajouterProduit() {
    FirebaseFirestore.instance.collection('produits').add({
      'nom': 'taha',
      'prix': 1600,
      'quantite': 13,
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des produits') ,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: db.collection('produits').snapshots(),
          builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snaphot)
          {
            if(snaphot.hasError){
              return const Center(child:Text("Ereure est survenue"));
            }

            if(snaphot.connectionState == ConnectionState.waiting)
            {
              return const Center(child: CircularProgressIndicator(),);
            }
          List<Produit> produits = snaphot.data!.docs.map((doc)
          {
            return Produit.fromFirestore(doc);
          }).toList();

          return  ListView.builder(itemCount: produits.length,
                                   itemBuilder: (context,index)=> ProduitItem(produit:produits[index],) ,);

          }, ),
          floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              ajouterProduit();
            },
            tooltip: 'Ajouter',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              supprimerProduit('emcUkHpaF0Bco2uDHyJM');
            },
            tooltip: 'Supprimer',
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}

/* void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(
    home:  ListeProduits(),
  ));
} */