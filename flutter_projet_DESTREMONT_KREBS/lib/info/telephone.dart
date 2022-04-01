import 'dart:convert';

class Telephone {
  // Les attributs ne sont pas 'final' car dans un cas plus complet
  // est amené à modifier les valeurs
  int _id;
  String _tel_perso;
// String _tel_pro;
// String _tel_portable;
  String _email;
  String _adresse_employeur;
            get id {
    return _id;
    }
           get email {
    return _email;
    }
           get adresse_employeur {
    return _adresse_employeur;
    }


  get tel_perso {
    return _tel_perso;
  }
  // get tel_pro {
  //   return _tel_pro;
  // }
  // get tel_portable {
  //   return _tel_portable;
  // }



  Telephone(this._id, this._tel_perso, this._email, this._adresse_employeur);

@override 
  String toString(){
    return '{id : $_id, rue: $_tel_perso}';
  }


  // Méthode utiisée par la DAO pour créer une
  // liste d'instances de Categorie
  // à partir d'une liste d'objets JSON
  static List<Telephone> listeFromJsonString(String sJSON) {
    List<Telephone> telephone = [];

    var json = jsonDecode(sJSON) as List;

    for (var value in json) {
      /*liste.add(Adresse(int.parse(value['id']),
          value['rue'], value['ville'], int.parse(value['batiment']), int.parse(value['codepostal'])));*/
          telephone.add(Telephone(int.parse(value['id']),
        value['tel_perso'],value['email'],value['adresse_employeur']));
    }

    return telephone;
  }
}