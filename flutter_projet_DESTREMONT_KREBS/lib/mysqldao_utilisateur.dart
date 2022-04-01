import 'package:http/http.dart' as http;
import './info/utilisateur.dart';


class MySQLDAOUtilisateur {
  static const String urlServeur =
      "https://devweb.iutmetz.univ-lorraine.fr/~destremo7u/";

  static Future<List<Utilisateur>> getUtilisateur() async {
    final response =
        await http.get(Uri.parse(urlServeur + 'get_utilisateur.php'));
    if (response.statusCode == 200) {
      return Utilisateur.listeFromJsonString(response.body);
    } else {
      throw Exception('Impossible de charger les categories');
    }
  }
}