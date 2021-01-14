import 'package:covid19apps/restservices.dart';
import 'package:flutter/material.dart';

class KenaikanDataCovidTiapHari extends StatefulWidget {
  @override
  _KenaikanDataCovidTiapHariState createState() => _KenaikanDataCovidTiapHariState();
}

class _KenaikanDataCovidTiapHariState extends State<KenaikanDataCovidTiapHari> {
  Fungsibulan(String bulan){
    String nama;
    if(bulan=='01'){
      nama = 'Januari';
    }
    else if(bulan=='02'){
      nama = 'Februari';
    }
    else if(bulan=='03'){
      nama = 'Maret';
    }
    else if(bulan=='04'){
      nama = 'April';
    }
    else if(bulan=='05'){
      nama = 'Mei';
    }
    else if(bulan=='06'){
      nama = 'Juni';
    }
    else if(bulan=='07'){
      nama = 'Juli';
    }
    else if(bulan=='08'){
      nama = 'Agustus';
    }
    else if(bulan=='09'){
      nama = 'September';
    }
    else if(bulan=='10'){
      nama = 'Oktober';
    }
    else if(bulan=='11'){
      nama = 'November';
    }
    else if(bulan=='12'){
      nama = 'Desember';
    }
    else {
      nama = 'lain';
    }
    return nama;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KENAIKAN TIAP HARI'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: ConnectToAPI.APIdatacovidharian(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    ListDataHarianCovid data = snapshot.data;
                    return ListView.builder(
                      itemCount: data.updatedatacovidharian.listdataharianindonesia.length,
                      itemBuilder: (context, index){
                        var splitdata = data.updatedatacovidharian.listdataharianindonesia[index].tanggal.toString().split("T")[0];
                        var split_tanggal = splitdata.toString().split("-");
                        var bulan = Fungsibulan(split_tanggal[1]);
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          child: Column(
                            children: <Widget>[
                              Text(split_tanggal[2] + " " + bulan + " " + split_tanggal[0], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.0),),
                              SizedBox(height: 15,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text('POSITIF'),
                                      SizedBox(height: 15,),
                                      Text(data.updatedatacovidharian.listdataharianindonesia[index].jumlah_positif.value.toString())
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text('MENINGGAL'),
                                      SizedBox(height: 15,),
                                      Text(data.updatedatacovidharian.listdataharianindonesia[index].jumlah_meninggal.value.toString()),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text('SEMBUH'),
                                      SizedBox(height: 15,),
                                      Text(data.updatedatacovidharian.listdataharianindonesia[index].jumlah_sembuh.value.toString())
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.red),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red,
                                offset: Offset(-5, 5)
                              )
                            ]
                          ),
                        );
                      },
                    );
                  }else{
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
