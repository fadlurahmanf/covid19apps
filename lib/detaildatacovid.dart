import 'package:covid19apps/detaildatacovidperprovinsi.dart';
import 'package:covid19apps/hal_kenaikan_tiap_hari.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid19apps/restservices.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DetailPageForCovid19 extends StatefulWidget {
  @override
  _DetailPageForCovid19State createState() => _DetailPageForCovid19State();
}

class _DetailPageForCovid19State extends State<DetailPageForCovid19> {

  List<LineChartData> datapositif = [];
  List<LineChartData> datasembuh = [];

  getDataAPI()async{
    var result = await ConnectToAPI.APIdatacovidharian();
    ListDataHarianCovid list = result;
    int panjangdata = list.updatedatacovidharian.listdataharianindonesia.length;
    for(int i=0;i<panjangdata;i++){
      var datatanggal = list.updatedatacovidharian.listdataharianindonesia[i].tanggal;
      var tanggal_lengkap = (datatanggal.split("T"))[0];
      var tahun = (tanggal_lengkap).split("-")[0];
      var bulan = (tanggal_lengkap).split("-")[1];
      var tanggal = (tanggal_lengkap).split("-")[2];
      datapositif.add(LineChartData(DateTime(int.parse(tahun), int.parse(bulan), int.parse(tanggal)), list.updatedatacovidharian.listdataharianindonesia[i].jumlah_positif.value));
      datasembuh.add(LineChartData(DateTime(int.parse(tahun), int.parse(bulan), int.parse(tanggal)), list.updatedatacovidharian.listdataharianindonesia[i].jumlah_sembuh.value));
      i+=5;
      setState(() {

      });
    }
  }

  getLineChart(){
    List<charts.Series<LineChartData, DateTime>> series = [
      charts.Series(
        id: 'Data Positif',
        domainFn: (LineChartData data,_)=>data.tanggal,
        measureFn: (LineChartData data,_)=>data.jumlah,
        data: datapositif,
        colorFn: (_,__)=> charts.MaterialPalette.red.shadeDefault,
      ),
      charts.Series(
        id: 'Data Sembuh',
        domainFn: (LineChartData data,_)=>data.tanggal,
        measureFn: (LineChartData data,_)=>data.jumlah,
        data: datasembuh,
        colorFn: (_,__)=> charts.MaterialPalette.blue.shadeDefault,
      )
    ];
    return series;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataAPI();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DETAIL DATA COVID 19'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Tap for detail', style: TextStyle(color: Colors.black, fontSize: 17, letterSpacing: -1),),
                    IconButton(icon: Icon(Icons.arrow_forward), onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>KenaikanDataCovidTiapHari()));
                    }, color: Colors.blue,),
                  ],
                ),
              ),
              FutureBuilder(
                future: ConnectToAPI.APIdatacovidharian(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    ListDataHarianCovid listdatahariancovid = snapshot.data;
                    return Container(
                      height: 180,
                      width: 390,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red,
                            offset: Offset(-4, 7),
                          )
                        ]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            // margin: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            height: 80,
                            child: Text('DATA DI INDONESIA HARI INI', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 20),),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                height: 100,
                                width: 130,
                                color: Colors.deepOrange,
                                child: Column(
                                  children: <Widget>[
                                    Text('POSITIF', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 12, letterSpacing: 1.0),),
                                    Text(listdatahariancovid.updatedatacovidharian.penambahan.jumlah_positif_hari_ini.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 130,
                                color: Colors.deepOrangeAccent,
                                child: Column(
                                  children: <Widget>[
                                    Text('MENINGGAL', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 12, letterSpacing: 1.0),),
                                    Text(listdatahariancovid.updatedatacovidharian.penambahan.jumlah_meninggal_hari_ini.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 130,
                                color: Colors.orangeAccent,
                                child: Column(
                                  children: <Widget>[
                                    Text('SEMBUH', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 12, letterSpacing: 1.0),),
                                    Text(listdatahariancovid.updatedatacovidharian.penambahan.jumlah_sembuh_hari_ini.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }else{
                    return CircularProgressIndicator();
                  }
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 25),
                child: Text('GRAFIK COVID 19 INDONESIA', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 18),),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                height: 300,
                child: charts.TimeSeriesChart(
                  getLineChart(),
                  animate: true,
                  dateTimeFactory: charts.LocalDateTimeFactory(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 15,
                    width: 15,
                    color: Colors.red,
                  ),
                  // SizedBox(width: 10,),
                  Text('Positif'),
                  Container(
                    height: 15,
                    width: 15,
                    color: Colors.blue,
                  ),
                  Text('Sembuh'),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text('DATA COVID PER PROVINSI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    ),
                    IconButton(icon: Icon(Icons.arrow_forward), onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailDataPerProvinsi()));
                    }, color: Colors.blue,),
                  ],
                ),
              ),
              Container(
                height: 250,
                width: 390,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red)
                ),
                child: Image.asset('assets/provinsi_indonesia.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LineChartData{
  DateTime tanggal;
  int jumlah;
  LineChartData(this.tanggal, this.jumlah);
}
