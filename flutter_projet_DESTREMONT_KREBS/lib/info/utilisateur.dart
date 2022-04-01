import 'dart:convert';

class Utilisateur {
  // Les attributs ne sont pas 'final' car dans un cas plus complet
  // est amené à modifier les valeurs
  int _id;
  String _nom;
  String _prenom;
  String _date_naissance;
  String _lieu_naissance;


            get id {
    return _id;
    }

  get nom {
    return _nom;
  }

    get prenom {
    return _prenom;
    }

        get date_naissance {
    return _date_naissance;
    }

            get lieu_naissance {
    return _lieu_naissance;
    }

  Utilisateur(this._id, this._nom, this._prenom, this._date_naissance, this._lieu_naissance);
@override 
  String toString(){
    return '{id : $_id, nom : $_nom}';
  }

  // Méthode utiisée par la DAO pour créer une
  // liste d'instances de Categorie
  // à partir d'une liste d'objets JSON
  static List<Utilisateur> listeFromJsonString(String sJSON) {
    List<Utilisateur> utilisateur = [];

    var json = jsonDecode(sJSON) as List;

    for (var value in json) {
      /*liste.add(Adresse(int.parse(value['id']),
          value['rue'], value['ville'], int.parse(value['batiment']), int.parse(value['codepostal'])));*/
          utilisateur.add(Utilisateur(int.parse(value['id']),
          value['nom'], value['prenom'], value['date_naissance'], value['lieu_naissance']));
    }

    return utilisateur;
  }
}