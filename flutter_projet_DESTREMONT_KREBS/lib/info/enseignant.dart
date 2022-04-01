import 'dart:convert';

class Enseignant {
  // Les attributs ne sont pas 'final' car dans un cas plus complet
  // est amené à modifier les valeurs
  int _id;
   String _statut;
  String _matieres_enseignees;
 
  String _annee;
  // String _nom_licence;
            get id {
    return _id;
    }
           get matieres_enseignees {
    return _matieres_enseignees;
    }
           get statut {
    return _statut;
    }

           get annee {
    return _annee;
    }


  // get nom_licence {
  //   return _nom_licence;
  // }
  // get tel_pro {
  //   return _tel_pro;
  // }
  // get tel_portable {
  //   return _tel_portable;
  // }



  Enseignant(this._id, this._matieres_enseignees,this._statut, this._annee);

@override 
  String toString(){
    return '{id : $_id, rue: $_matieres_enseignees}';
  }


  // Méthode utiisée par la DAO pour créer une
  // liste d'instances de Categorie
  // à partir d'une liste d'objets JSON
  static List<Enseignant> listeFromJsonString(String sJSON) {
    List<Enseignant> enseignant = [];

    var json = jsonDecode(sJSON);

    for (var value in json) {
      /*liste.add(Adresse(int.parse(value['id']),
          value['rue'], value['ville'], int.parse(value['batiment']), int.parse(value['codepostal'])));*/
          enseignant.add(Enseignant(int.parse(value['id']),
        value['matieres_enseignees'],value['statut'],value['annee']));
    }

    return enseignant;
  }
}