import 'package:covid19apps/detaildatacovidperprovinsi.dart';
import 'package:flutter/material.dart';
import 'package:covid19apps/restservices.dart';

class DetailPageForCovid19 extends StatefulWidget {
  @override
  _DetailPageForCovid19State createState() => _DetailPageForCovid19State();
}

class _DetailPageForCovid19State extends State<DetailPageForCovid19> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DETAIL DATA COVID 19'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: <Widget>[
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
            // RaisedButton(onPressed: ()async{
            //   var result = await ConnectToAPI.APIdatacovidharian();
            //   print(result.updatedatacovidharian.penambahan.jumlah_meninggal_hari_ini);
            // }),
            SizedBox(height: 60,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: EdgeInsets.symmetric(vertical: 10),
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
    );
  }
}



// Container(
// color: Colors.orange,
// height: 180,
// width: 360,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: <Widget>[
// Container(
// margin: EdgeInsets.symmetric(vertical: 10),
// alignment: Alignment.center,
// child: Text('DATA DI INDONESIA HARI INI', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0),),
// ),
// Row(
// children: <Widget>[
// Container(
// height: 100,
// width: 120,
// color: Colors.black,
// ),
// Container(
// height: 100,
// width: 120,
// color: Colors.blue,
// ),
// Container(
// height: 100,
// width: 120,
// color: Colors.grey,
// ),
// ],
// )
// ],
// ),
// ),
