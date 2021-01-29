import 'dart:convert';

import 'package:http/http.dart' as http;

class ListCountry{
  List<Data> list;
  ListCountry({this.list});
  factory ListCountry.fromJson(List<dynamic> object){
    List<Data> listdata = List<Data>();
    listdata = object.map((e) => Data.fromJson(e)).toList();
    return ListCountry(
      list: listdata,
    );
  }
}

class Data{
  Parameter data;
  Data({this.data});
  factory Data.fromJson(Map<String, dynamic> object){
    return Data(
      data: Parameter.fromJson(object['attributes']),
    );
  }
}

class Parameter{
  String countryname;
  String positif;
  String meninggal;
  String sembuh;
  Parameter({this.countryname, this.positif, this.meninggal, this.sembuh});
  factory Parameter.fromJson(Map<String, dynamic> object){
    return Parameter(
      countryname: object['Country_Region'],
      positif: object['Confirmed'].toString(),
      meninggal: object['Deaths'].toString(),
      sembuh: object['Recovered'].toString(),
    );
  }
}

class ConnectToAPIGLOBAL{
  static Future APIglobal()async{
    final String APIurl =  'https://api.kawalcorona.com/';
    var response = await http.get(APIurl);
    var jsonResult = json.decode(response.body);
    return ListCountry.fromJson(jsonResult);
  }
}