import 'package:intl/intl.dart';

import '../../config/api.dart';
import '../../config/app_request.dart';

class SourceHistory {
  static Future<Map> analysis(String idUser) async {
    String url = '${Api.history}/analysis.php';
    Map? responseBody =
        await AppRequest.post(url, {
          'id_user': idUser,
          'today': DateFormat('yyyy-mm-dd').format(DateTime.now())
        });

    if (responseBody == null) {
      return {
      'today': 0,
      'yesterday': 0,
      'week': [0,0,0,0,0,0,0],
      'month':{
        'income': 0,
        'outcome': 0
      }
    };
    }

    return responseBody;
  }
}
