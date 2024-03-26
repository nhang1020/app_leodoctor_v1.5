import 'dart:convert';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/phieuSoHoa.dart';
import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class PhieuSoHoaController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<List<PhieuSoHoaData>> getPhieuSoHoa() async {
    List<PhieuSoHoaData> lstPhieuSo = [];

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.get(Uri.parse(_api.Url_PhieuSoHoa()),
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var data = PhieuSoHoa.fromJson(jsonDecode(response.body));
        lstPhieuSo = data.data;
      }
    } catch (e) {
      print(e);
    }

    return lstPhieuSo;
  }

  Future<OutUpPhieuSoHoaData> uploadPhieuSoHoa(UpPhieuSoHoa psh) async {
    String token = await _localData.Shared_getToken();
    OutUpPhieuSoHoaData output =
        OutUpPhieuSoHoaData(idPhieu: '', tenphieu: '', urlHtml: '');
    try {
      final response = await http.post(
        Uri.parse(_api.Url_UploadPhieuSoHoa()),
        body: {
          "mahs": psh.mahs,
          "mabn": psh.mabn,
          "id_emr": psh.idEmr,
          "file_name": psh.fileName,
          "base64": psh.base64,
        },
        headers: {'Authorization': 'Bearer $token'},
      );
      var data = OutUpPhieuSoHoa.fromJson(jsonDecode(response.body));
      output = data.data;
    } catch (e) {
      print(e);
    }
    return output;
  }
}
