import 'dart:convert';

import 'package:http/http.dart' as http;

class ListData{
  List<DataCovidIndonesia> listdata;

  ListData({this.listdata});

  factory ListData.fromJson(List<dynamic> object){
    List<DataCovidIndonesia> list = List<DataCovidIndonesia>();
    list = object.map((e) => DataCovidIndonesia.fromJson(e)).toList();

    return ListData(
      listdata: list,
    );
  }
}

class DataCovidIndonesia{
  String namanegara;
  String totalkasus;
  String totalsembuh;
  DataCovidIndonesia({this.namanegara, this.totalkasus, this.totalsembuh});

  factory DataCovidIndonesia.fromJson(Map<String, dynamic> object){
    return DataCovidIndonesia(
      namanegara: object["name"],
      totalkasus: object["positif"],
      totalsembuh: object["sembuh"],
    );
  }
}

//API RUMAH SAKIT//

class ListRS{
  List<RumahSakit> listrumahsakit;

  ListRS({this.listrumahsakit});

  factory ListRS.fromJson(List<dynamic> object){
    List<RumahSakit> list = List<RumahSakit>();
    list = object.map((e) => RumahSakit.fromJson(e)).toList();

    return ListRS(
      listrumahsakit: list,
    );
  }

}

class RumahSakit{
  String namarumahsakit;
  String alamat;
  String notelp;
  String daerah;

  RumahSakit({this.namarumahsakit, this.alamat, this.notelp, this.daerah});

  factory RumahSakit.fromJson(Map<String, dynamic> object){
    return RumahSakit(
      namarumahsakit: object["name"],
      alamat: object["address"],
      notelp: object["phone"],
      daerah: object["province"],
    );
  }
}

class ListDataHarianCovid{
  UpdateDataCovid updatedatacovidharian;
  
  ListDataHarianCovid({this.updatedatacovidharian});
  
  factory ListDataHarianCovid.fromJson(Map<String, dynamic> object){
    return ListDataHarianCovid(
      updatedatacovidharian: UpdateDataCovid.fromJson(object["update"]),
    );
  }
}

class UpdateDataCovid{
  Penambahan penambahan;
  List<DataHarianIndonesia> listdataharianindonesia;

  UpdateDataCovid({this.penambahan, this.listdataharianindonesia});

  factory UpdateDataCovid.fromJson(Map<String, dynamic> object){
    var data = object["harian"] as List;
    List<DataHarianIndonesia> dataharian = data.map((e) => DataHarianIndonesia.fromJson(e)).toList();
    return UpdateDataCovid(
      penambahan: Penambahan.fromJson(object["penambahan"]),
      listdataharianindonesia: dataharian,
    );
  }
}

class Penambahan{
  dynamic jumlah_positif_hari_ini;
  dynamic jumlah_meninggal_hari_ini;
  dynamic jumlah_sembuh_hari_ini;

  Penambahan({this.jumlah_positif_hari_ini, this.jumlah_meninggal_hari_ini, this.jumlah_sembuh_hari_ini});

  factory Penambahan.fromJson(Map<String, dynamic> object){
    return Penambahan(
      jumlah_positif_hari_ini: object["jumlah_positif"],
      jumlah_meninggal_hari_ini: object["jumlah_meninggal"],
      jumlah_sembuh_hari_ini: object["jumlah_sembuh"],
    );
  }
}

class DataHarianIndonesia{
  dynamic tanggal;
  Value jumlah_meninggal;
  Value jumlah_positif;
  Value jumlah_sembuh;

  DataHarianIndonesia({this.tanggal, this.jumlah_meninggal, this.jumlah_positif, this.jumlah_sembuh});

  factory DataHarianIndonesia.fromJson(Map<String, dynamic> object){
    return DataHarianIndonesia(
      tanggal: object["key_as_string"],
      jumlah_meninggal: Value.fromJson(object["jumlah_meninggal"]),
      jumlah_positif: Value.fromJson(object["jumlah_positif"]),
      jumlah_sembuh: Value.fromJson(object["jumlah_sembuh"]),
    );
  }
}

class Value{
  dynamic value;
  Value({this.value});

  factory Value.fromJson(Map<String, dynamic> object){
    return Value(
      value: object["value"],
    );
  }
}

// class ValueJumMeninggalPerHari{
//   dynamic jumlah_meninggal;
//
//   ValueJumMeninggalPerHari({this.jumlah_meninggal});
//
//   factory ValueJumMeninggalPerHari.fromJson(Map<String, dynamic> object){
//     return ValueJumMeninggalPerHari(
//       jumlah_meninggal: object["value"].toString(),
//     );
//   }
// }

class DataCovidTiapProvinsi{
  dynamic tanggal_terakhir;
  List<DataCovidPerProvinsiTiapProvinsi> datacovidperprovinsitiap_provinsi;

  DataCovidTiapProvinsi({this.tanggal_terakhir, this.datacovidperprovinsitiap_provinsi});

  factory DataCovidTiapProvinsi.fromJson(Map<String, dynamic> object){
    var datatiapkota = object["list_data"] as List;
    List<DataCovidPerProvinsiTiapProvinsi> listdatatiapkota = datatiapkota.map((e) => DataCovidPerProvinsiTiapProvinsi.fromJson(e)).toList();
    return DataCovidTiapProvinsi(
      tanggal_terakhir: object["last_date"].toString(),
      datacovidperprovinsitiap_provinsi: listdatatiapkota,
    );
  }
}

class DataCovidPerProvinsiTiapProvinsi{
  String kota;
  dynamic jumlah_kasus;
  dynamic jumlah_meninggal;
  dynamic jumlah_sembuh;

  DataCovidPerProvinsiTiapProvinsi({this.kota, this.jumlah_kasus, this.jumlah_meninggal, this.jumlah_sembuh});

  factory DataCovidPerProvinsiTiapProvinsi.fromJson(Map<String, dynamic> object){
      return DataCovidPerProvinsiTiapProvinsi(
        kota: object["key"],
        jumlah_kasus: object["jumlah_kasus"],
        jumlah_meninggal: object["jumlah_meninggal"],
        jumlah_sembuh: object["jumlah_sembuh"],
    );
  }
}

class ConnectToAPI{

  static Future<ListData> APIdataTotalINDONESIA() async{

    final String APIurl = "https://api.kawalcorona.com/indonesia/";

    var response = await http.get(APIurl);
    var jsonResult = json.decode(response.body);
    return ListData.fromJson(jsonResult);
  }

  static Future<ListRS> APIrumahsakitINDONESIA() async{
    final String APIurl = "https://dekontaminasi.com/api/id/covid19/hospitals";

    var response = await http.get(APIurl);
    var jsonResult = json.decode(response.body);
    return ListRS.fromJson(jsonResult);
  }

  static Future<ListDataHarianCovid> APIdatacovidharian() async{
    final String APIurl = "https://data.covid19.go.id/public/api/update.json";

    var response = await http.get(APIurl);
    var jsonResult = json.decode(response.body);
    return ListDataHarianCovid.fromJson(jsonResult);
  }

  static Future<DataCovidTiapProvinsi> APIdatacovidtiapProvinsi()async{
    final String APIurl = "https://data.covid19.go.id/public/api/prov.json";

    var response = await http.get(APIurl);
    var jsonResult = json.decode(response.body);
    return DataCovidTiapProvinsi.fromJson(jsonResult);
  }
}