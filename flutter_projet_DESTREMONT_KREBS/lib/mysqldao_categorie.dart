import 'package:http/http.dart' as http;
import './info/adresse.dart';

class MySQLDAOAdresse {
  static const String urlServeur =
      "https://devweb.iutmetz.univ-lorraine.fr/~destremo7u/";

  static Future<List<Adresse>> getAdresse() async {
    final response =
        await http.get(Uri.parse(urlServeur + 'get_adresse.php'));
    if (response.statusCode == 200) {
      return Adresse.listeFromJsonString(response.body);
    } else {
      throw Exception('Impossible de charger les categories');
    }
  }
}