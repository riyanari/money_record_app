import 'package:d_info/d_info.dart';
import 'package:intl/intl.dart';

import '../../config/api.dart';
import '../../config/app_request.dart';

class SourceHistory {
  static Future<Map> analysis(String idUser) async {
    String url = '${Api.history}/analysis.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'today': DateFormat('yyyy-MM-dd').format(DateTime.now())
    });
    print("repBody:");
    print(responseBody);

    if (responseBody == null) {
      return {
        'today': 0.0,
        'yesterday': 0.0,
        'week': [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
        'month': {'income': 0.0, 'outcome': 0.0}
      };
    }

    return responseBody;
  }

  static Future<bool> add(String idUser, String date, String type,
      String details, String total) async {
    String url = '${Api.history}/add.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'date': date,
      'type': type,
      'details': details,
      'total': total,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String()
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess("Berhasil tambah history");
      DInfo.closeDialog();
    } else {
      if (responseBody['message'] == 'date') {
        DInfo.dialogError(
            "History dengan tanggal tersebut sudah pernah dibuat");
      } else {
        DInfo.dialogError("Gagal tambah history");
      }
      DInfo.closeDialog();
    }
    return responseBody['success'];
  }
}
