import 'package:http/http.dart' as http;
import './info/enseignant.dart';

class MySQLDAOEnseignant {
  static const String urlServeur =
      "https://devweb.iutmetz.univ-lorraine.fr/~destremo7u/";

  static Future<List<Enseignant>> getEnseignant() async {
    final response =
        await http.get(Uri.parse(urlServeur + 'get_enseignant.php'));
    if (response.statusCode == 200) {
      return Enseignant.listeFromJsonString(response.body);
    } else {
      throw Exception('Impossible de charger les categories');
    }
  }
}