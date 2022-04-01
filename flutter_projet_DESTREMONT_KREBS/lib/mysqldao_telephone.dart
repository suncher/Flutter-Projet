import 'package:http/http.dart' as http;
import './info/telephone.dart';

class MySQLDAOTelephone {
  static const String urlServeur =
      "https://devweb.iutmetz.univ-lorraine.fr/~destremo7u/";

  static Future<List<Telephone>> getTelephone() async {
    final response =
        await http.get(Uri.parse(urlServeur + 'get_telephone.php'));
    if (response.statusCode == 200) {
      return Telephone.listeFromJsonString(response.body);
    } else {
      throw Exception('Impossible de charger les categories');
    }
  }
}