import 'dart:convert';

class Adresse {
  // Les attributs ne sont pas 'final' car dans un cas plus complet
  // est amené à modifier les valeurs
  int _id;
  String _rue;
  String _ville;
  String _batiment;
  String _code_postal;


            get id {
    return _id;
    }

  get rue {
    return _rue;
  }

    get ville {
    return _ville;
    }

        get batiment {
    return _batiment;
    }

            get code_postal {
    return _code_postal;
    }

  Adresse(this._id, this._rue, this._ville, this._batiment, this._code_postal);

  @override
  String toString(){
    return '{id : $_id, rue: $_rue}';
  }


  // Méthode utiisée par la DAO pour créer une
  // liste d'instances de Categorie
  // à partir d'une liste d'objets JSON
  static List<Adresse> listeFromJsonString(String sJSON) {
    List<Adresse> adresse = [];

    var json = jsonDecode(sJSON) as List;

    for (var value in json) {
      /*liste.add(Adresse(int.parse(value['id']),
          value['rue'], value['ville'], int.parse(value['batiment']), int.parse(value['codepostal'])));*/
          adresse.add(Adresse(int.parse(value['id']),
          value['rue'], value['ville'], value['batiment'], value['code_postal']));
    }

    return adresse;
  }
}

