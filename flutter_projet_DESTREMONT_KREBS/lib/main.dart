import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'mysqldao_categorie.dart';
import './info/adresse.dart';
import 'mysqldao_utilisateur.dart';
import './info/utilisateur.dart';
import 'mysqldao_telephone.dart';
import './info/telephone.dart';
import 'mysqldao_enseignant.dart';
import './info/enseignant.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Formulaire de login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  // Contrôleurs pour les champs de saisie
  final TextEditingController _ctrlNom = TextEditingController();
  final TextEditingController _ctrlPrenom = TextEditingController();
  final TextEditingController _ctrlLieuNaissance = TextEditingController();
  final TextEditingController _ctrlDateNaissance = TextEditingController();
  final TextEditingController _ctrlRue = TextEditingController();
  final TextEditingController _ctrlBatiment = TextEditingController();
  final TextEditingController _ctrlVille = TextEditingController();
  final TextEditingController _ctrlCodePostal = TextEditingController();
  final TextEditingController _ctrlTelPerso = TextEditingController();
  final TextEditingController _ctrlTelPortable = TextEditingController();
  final TextEditingController _ctrlTelPro = TextEditingController();
  final TextEditingController _ctrlAdresseMail = TextEditingController();
  final TextEditingController _ctrlAdresseEmployeur = TextEditingController();
  final TextEditingController _ctrlMatieresEnseignees = TextEditingController();


  // Identifiant pour le formulaire
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'Titulaire';
  String dropdownValue2 = '2eme annee';
  bool _souvenir = false;
  bool isCheckedBUT = false;
  bool isChecked2emeannee = false;
  bool isCheckedLicence = false;
  bool isCheckedAnneeSpeciale = false;
  void onChangeSouvenir(bool? checked) {
    setState(() {
      _souvenir = checked!;
    });
  }

    void clicLogin(){
    if (_formKey.currentState!.validate()){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connexion de ' + this._ctrlNom.text)),
      );
      var url = Uri.parse(
      "https://devweb.iutmetz.univ-lorraine.fr/~destremo7u/insert.php?nom=" 
      + _ctrlNom.text 
      + "&prenom=" + _ctrlPrenom.text
      + "&lieu_naissance=" + _ctrlLieuNaissance.text
      + "&date_naissance=" + _ctrlDateNaissance.text
      + "&rue=" + _ctrlRue.text
      +"&batiment=" + _ctrlBatiment.text
      +"&ville=" + _ctrlVille.text
      +"&code_postal=" + _ctrlCodePostal.text
      +"&tel_perso=" + _ctrlTelPerso.text
      +"&tel_portable=" + _ctrlTelPortable.text
      +"&tel_pro=" + _ctrlTelPro.text
      +"&email=" + _ctrlAdresseMail.text
      +"&adresse_employeur=" + _ctrlAdresseEmployeur.text
      +"&statut=" + dropdownValue
      +"&matieres_enseignees=" + _ctrlMatieresEnseignees.text 
      +"&annee=" + dropdownValue2 

      );
    http.get(url);


          Navigator.push(
          context,
          MaterialPageRoute(builder:(context) =>  MySecondScreen()),
        );
    }
  }

  // Clic sur le bouton =>
  // Validation du formulaire, puis affichage :
  // Si ok : petit message avec le nom de la personne
  // Sinon : messages d'erreurs renvoyés par le validator
  void onClicConnexion() {
    if (_formKey.currentState!.validate()) {
      var snackBar = SnackBar(
        content: Text('Bienvenue ' + _ctrlNom.text),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sur smartphone, pour éviter que le clavier fasse reonter l'interface
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          margin: const EdgeInsets.all(0),
          color: Colors.grey[200],
          child: OrientationBuilder(
            builder: (context, orientation) {
              return  Form(
                key: _formKey,
                child : SingleChildScrollView(
                  child :Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 30),
                      child: const Text(
                        'Informations personnelles',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  _buildColumnSaisieInfoPerso(),

                        Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 30),
                      child: const Text(
                        'Adresse',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    _buildColumnSaisieAdresse(),

                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 30),
                      child: const Text(
                        'Information complémentaires',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    _buildColumnSaisieInfoComp(),

                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 30),
                      child: const Text(
                        'Enseignant',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    _buildColumnSaisieEnseignant(),

                            ElevatedButton(
            onPressed: clicLogin,
            child: const Text('Connexion'),
          ),

                  ],
                ),
                )
                );
              
              
            },
          ),
        ),
      ),
    );
  }

  Widget _buildColumnSaisieInfoPerso() {
    return Column(
      children: [_buildChampNom(), _buildChampPrenom(), _buildChampLieuNaissance(), _buildChampDateNaissance()] 
    );
  }

  Widget _buildColumnSaisieAdresse() {
    return Column(
      children: [_buildChampRue(), _buildChampBatiment(), _buildChampVille(), _buildChampCodePostal()] 
    );
  }

   Widget _buildColumnSaisieInfoComp() {
    return Column(
      children: [_buildChampTelPerso(), _buildChampTelPortable(), _buildChampTelPro(), _buildChampAdresseMail(), _buildChampAdresseEmployeur()] 
    );
  }

   Widget _buildColumnSaisieEnseignant() {
    return Column(
      children: [_buildChampEnseignant(), _buildChampAnnee(), _buildChampMatieresEnseignees()] 
    );
  }



  Widget _buildChampNom() {
    return TextFormField(
      controller: _ctrlNom,
      decoration: const InputDecoration(hintText: 'Nom'),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Le login est obligatoire !';
        }
        return null;
      },
    );
  }

  Widget _buildChampPrenom() {
    return TextFormField(
      controller: _ctrlPrenom,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Le mot de passe est obligatoire !';
        }
        return null;
      },
      
      decoration: const InputDecoration(hintText: 'Prénom'),
    );
  }

    Widget _buildChampLieuNaissance() {
    return TextFormField(
      controller: _ctrlLieuNaissance,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Le date de naissance est obligatoire !';
        }
        return null;
      },
      
      decoration: const InputDecoration(hintText: 'Date de naissance'),
    );
  }

      Widget _buildChampDateNaissance() {
    return TextFormField(
      controller: _ctrlDateNaissance,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Le date de naissance est obligatoire !';
        }
        return null;
      },
      
      decoration: const InputDecoration(hintText: 'Date de naissance'),
    );
  }

        Widget _buildChampRue() {
    return TextFormField(
      controller: _ctrlRue,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Le rue est obligatoire !';
        }
        return null;
      },
      
      decoration: const InputDecoration(hintText: 'Rue'),
    );
  }

          Widget _buildChampBatiment() {
    return TextFormField(
      controller: _ctrlBatiment,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Le batiment est obligatoire !';
        }
        return null;
      },
      
      decoration: const InputDecoration(hintText: 'Batiment'),
    );
  }

          Widget _buildChampVille() {
    return TextFormField(
      controller: _ctrlVille,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Le ville est obligatoire !';
        }
        return null;
      },
      
      decoration: const InputDecoration(hintText: 'Ville'),
    );
  }

          Widget _buildChampCodePostal() {
    return TextFormField(
      controller: _ctrlCodePostal,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Le code postal est obligatoire !';
        }
        return null;
      },
      
      decoration: const InputDecoration(hintText: 'Code Postal'),
    );
  }

            Widget _buildChampTelPerso() {
    return TextFormField(
      controller: _ctrlTelPerso,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Le numéro personnel est obligatoire !';
        }
        return null;
      },
      decoration: const InputDecoration(hintText: 'Numéro de Téléphone personnel'),
    );
  }

            Widget _buildChampTelPortable() {
    return TextFormField(
      controller: _ctrlTelPortable,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Le numéro de portable est obligatoire !';
        }
        return null;
      },
      
      decoration: const InputDecoration(hintText: 'Numéro de téléphone portable'),
    );
  }

              Widget _buildChampTelPro() {
    return TextFormField(
      controller: _ctrlTelPro,
            validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Le numéro professionnel est obligatoire !';
        }
        return null;
      },
      decoration: const InputDecoration(hintText: 'Numéro de téléphone professionnel'),
    );
  }

            Widget _buildChampAdresseMail() {
    return TextFormField(
      controller: _ctrlAdresseMail,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return"L'adresse mail est obligatoire !";
        }
        return null;
      },
      
      decoration: const InputDecoration(hintText: 'Adresse Mail'),
    );
  }

              Widget _buildChampAdresseEmployeur() {
    return TextFormField(
      controller: _ctrlAdresseEmployeur,
            validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'L\'adresse de l\'employeur est obligatoire!';
        }
        return null;
      },
      decoration: const InputDecoration(hintText: "Adresse de l'employeur"),
    );
  }

                Widget _buildChampMatieresEnseignees() {
    return TextFormField(
      controller: _ctrlMatieresEnseignees,
      
      decoration: const InputDecoration(hintText: "Matières enseignées"),
    );
  }

              Widget _buildChampEnseignant() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.blue),
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Titulaire','Vacataire', 'ATER', 'Moniteur']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildChampAnnee() {
    return DropdownButton<String>(
      value: dropdownValue2,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.blue),
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue2 = newValue!;
        });
      },
      items: <String>['2eme annee','BUT', 'Annee speciale', 'Licence']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class MySecondScreen extends StatefulWidget {
const MySecondScreen({Key? key}) : super(key : key);

    static const String _title = 'Flutter Code Sample';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),

      ),
    );
  }
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".




  @override
  _MySecondScreen createState() => _MySecondScreen();
}

class _MySecondScreen extends State<MySecondScreen> {
   


  @override
  void initState() {
    _chargeUtilisateur();
    _chargeTelephone();
    super.initState();
  }

//     void _runFilter (String enteredKeyword) async {
// var url = Uri.parse(
//       "https://devweb.iutmetz.univ-lorraine.fr/~destremo7u/get_utlisateurtable.php?nom=" 
//       + enteredKeyword


//       );
//     http.get(url);
//     print(url);
//     http.Response response = await http.get(url);
//     List<dynamic> _user = jsonDecode(response.body);
    
//   }


    void _chargeUtilisateur() async {
    _utilisateur = await MySQLDAOUtilisateur.getUtilisateur();
    setState(() {});
  }
List<Utilisateur>? _utilisateur;

    void _chargeTelephone() async {
    _telephone = await MySQLDAOTelephone.getTelephone();
    setState(() {});
  }
List<Telephone>? _telephone;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion des catégories"),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
      Expanded( child :
      _utilisateur == null
          ? const Center(
              child: Text("Chargement en cours..."),
            )
          :  
 
          ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                for (var idx = 0; idx < _utilisateur!.length; idx++)
                  ListTile(
                    title: Text(_utilisateur![idx].prenom + ' '+ _utilisateur![idx].nom),
                    subtitle: Text(_telephone![idx].tel_perso),
                                        onTap: () {
                                                Navigator.push(
          context,
          MaterialPageRoute(builder:(context) => new MyThirdPage(_utilisateur![idx].id)));
                    },
                  )

              ],
            ),
      )
      ]
          )
    )
    );
  }



  
}



class MyThirdPage extends StatefulWidget {
     MyThirdPage(this.id, {Key? key}) : super(key: key);
  var id;
 var nom;
 var prenom;
 var email;
 var lieu_naissance;
 var date_naissance;
 var rue;
 var batiment;
 var ville;
 var code_postal;
 var tel_perso;
 var tel_pro;
 var tel_portable;
 var adressemail;
 var adresseemployeur;
 var statut;
 var matieres_enseignees;
 var annee;
 var nom_licence;

  // Un StatefulWidget est immuable, la variable sont donc constantes
   
  @override
  State<MyThirdPage> createState() => _MyThirdPageState();
}

 
class _MyThirdPageState extends State<MyThirdPage> {
  bool showWidget=false;

  void initState() {
    _chargeAdresse();
    _chargeUtilisateur();
    _chargeTelephone();
    _chargeEnseignant();
    // _main(_adresse,_utilisateur,_telephone,_enseignant, widget.id);
    super.initState();


  }



    void _chargeAdresse() async {
    _adresse = await MySQLDAOAdresse.getAdresse();
    setState(() {
    });
  }
List<Adresse>? _adresse;

    void _chargeUtilisateur() async {
    _utilisateur = await MySQLDAOUtilisateur.getUtilisateur();
    setState(() {
    });
  }
List<Utilisateur>? _utilisateur;

    void _chargeTelephone() async {
    _telephone = await MySQLDAOTelephone.getTelephone();
    setState(() {});
  }
List<Telephone>? _telephone;

   void _chargeEnseignant() async {
   _enseignant = await MySQLDAOEnseignant.getEnseignant();
   setState(() {});
 }
List<Enseignant>? _enseignant;

  void _main(List<Adresse>? _adresse,List<Utilisateur>? _utilisateur ,List<Telephone>? _telephone ,List<Enseignant>? _enseignant ,int id){
     for(var i = 0; i < _adresse!.length; i++){
       if(_adresse[i].id == id){
var adresse = _adresse[i];

         setState(() {
               widget.rue = adresse.rue;
       widget.batiment = adresse.batiment;
       widget.ville = adresse.ville;
       widget.code_postal = adresse.code_postal;     
                  });
       }
     }
                    for(var i = 0; i < _enseignant!.length; i++){
       if(_enseignant[i].id == id){
         var enseignant = _enseignant[i];
                       setState(() {
       widget.statut = enseignant.statut;
       widget.matieres_enseignees = enseignant.matieres_enseignees;
       widget.annee = enseignant.annee;

     });
       }
     }
          for(var i = 0; i < _utilisateur!.length; i++){
       if(_utilisateur[i].id == id){
         var user = _utilisateur[i];

              setState(() {
       widget.nom = user.nom;
       widget.prenom = user.prenom;
       widget.lieu_naissance = user.lieu_naissance;
       widget.date_naissance = user.date_naissance;
     });
       }
     }
               for(var i = 0; i < _telephone!.length; i++){
       if(_telephone[i].id == id){
         var telephone = _telephone[i];
                       setState(() {
       widget.tel_perso = telephone.tel_perso;
       widget.email = telephone.email;
       widget.adresseemployeur = telephone.adresse_employeur;
     });
       }
     }


  }

  


@override
Widget build(BuildContext context) {
  // return Scaffold(
  //     appBar: AppBar(title: const Text("Modification du mot de passe")),
  //     body:
  //         // Gestion du bouton back de l'appBar ET du téléphone
  //         WillPopScope(
  //       onWillPop: () async {
  //         Navigator.pop(context);
  //         return false;
  //       },
  //       child: Center(
  //         child: Container(
  //           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
  //           margin: const EdgeInsets.all(10),
  //           color: Colors.grey[200],
  //             child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   Padding(
  //                       padding: const EdgeInsets.only(top: 30, bottom: 70),
  //                       child: Text(
  //                         'Bienvenue ' + widget.id.toString(),
  //                         style: const TextStyle(fontSize: 20),
  //                       )),
  //                       IconButton(
  //                                icon: new Icon(Icons.bookmark),
  //                                onPressed: () { 
  //                                  _main(_adresse, _utilisateur, _telephone, _enseignant, widget.id);
  //                                 },
  //                              ),

  //                 ]),
  //           ),
  //         ),
  //       ),
  //     );
    
return Scaffold(
  resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('third page'),
      ),
      body: Center(
        child: Container(
child : SingleChildScrollView(
                  child :Column(
                  children: [
                   Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 30),
                      child: const Text(
                        'Informations personnelles',
                        style: TextStyle(fontSize: 20),
                      ),
                    ), 
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child:  Text.rich(
  TextSpan(
    text: 'Nom : ', // default text style
    children: <TextSpan>[
      TextSpan(text: widget.nom, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
    ],
  ),
)
                    ),
                     Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child:  Text.rich(
  TextSpan(
    text: 'Prénom : ', // default text style
    children: <TextSpan>[
      TextSpan(text: widget.prenom, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
    ],
  ),
)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child:  Text.rich(
  TextSpan(
    text: 'Lieu de naissance : ', // default text style
    children: <TextSpan>[
      TextSpan(text: widget.lieu_naissance, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
    ],
  ),
)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child:  Text.rich(
  TextSpan(
    text: 'Date de naissance : ', // default text style
    children: <TextSpan>[
      TextSpan(text: widget.date_naissance, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
    ],
  ),
)
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 30),
                      child: const Text(
                        'Adresse',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child:  Text.rich(
  TextSpan(
    text: 'Rue : ', // default text style
    children: <TextSpan>[
      TextSpan(text: widget.rue, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
    ],
  ),
)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child:  Text.rich(
  TextSpan(
    text: ' Batiment : ', // default text style
    children: <TextSpan>[
      TextSpan(text: widget.batiment, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
    ],
  ),
)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child:  Text.rich(
  TextSpan(
    text: 'Ville : ', // default text style
    children: <TextSpan>[
      TextSpan(text: widget.ville, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
    ],
  ),
)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text.rich(
  TextSpan(
    text: 'Code postal : ', // default text style
    children: <TextSpan>[
      TextSpan(text: widget.code_postal, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
    ],
  ),
)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 30),
                      child: const Text(
                        'Renseignement complémentaires',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child:  Text.rich(
  TextSpan(
    text: 'Télephone personnel : ', // default text style
    children: <TextSpan>[
      TextSpan(text: widget.tel_perso, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
    ],
  ),
)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child:  Text.rich(
  TextSpan(
    text: ' Adresse mail : ', // default text style
    children: <TextSpan>[
      TextSpan(text: widget.email, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
    ],
  ),
)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child:  Text.rich(
  TextSpan(
    text: 'Adresse de l\'employeur : ', // default text style
    children: <TextSpan>[
      TextSpan(text: widget.adresseemployeur, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
    ],
  ),
)
                    ),
                   
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 30),
                      child: const Text(
                        'Enseignant',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child:  Text.rich(
  TextSpan(
    text: 'Statut : ', // default text style
    children: <TextSpan>[
      TextSpan(text: widget.statut, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
    ],
  ),
)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child:  Text.rich(
  TextSpan(
    text: ' Matières enseignées : ', // default text style
    children: <TextSpan>[
      TextSpan(text: widget.matieres_enseignees, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
    ],
  ),
)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child:  Text.rich(
  TextSpan(
    text: 'Année : ', // default text style
    children: <TextSpan>[
      TextSpan(text: widget.annee, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
    ],
  ),
)
                    ),
                   
 FloatingActionButton(
        onPressed: () {
          _main(_adresse,_utilisateur,_telephone,_enseignant, widget.id);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.navigation,)
      ),



    

                    
                    
                  ]
                  )
)
        )

        
      )
);

  }
  }

