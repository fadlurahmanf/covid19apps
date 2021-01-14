import 'package:covid19apps/detaildatacovid.dart';
import 'package:covid19apps/halamanrumahsakitrujukan.dart';
import 'package:covid19apps/restservices.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List bulan=["Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"];
  var now = DateTime.now();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 23),),
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        color: Colors.grey[100],
        margin: EdgeInsets.symmetric(vertical: 0),
        child: Column(
          children: <Widget>[
            Container(margin: EdgeInsets.symmetric(vertical: 15),alignment: Alignment.center,child: Text('INDONESIA', style: TextStyle(letterSpacing: 1.0, fontWeight: FontWeight.bold, fontSize: 22),)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 200,
              width: 350,
              child: Image.asset('assets/indonesianmaps.png'),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.red),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red,
                    offset: Offset(-5 , 5),
                  )
                ]
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text('DATA COVID PER ' + now.day.toString().toUpperCase() +" "+ bulan[now.month-1].toString().toUpperCase() + " " + now.year.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  IconButton(icon: Icon(Icons.arrow_forward), onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPageForCovid19()));
                  }, color: Colors.blue,),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 120,
                  width: 180,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: FutureBuilder(
                            future: ConnectToAPI.APIdataTotalINDONESIA(),
                            builder: (context, snapshot){
                              if(snapshot.hasData){
                                ListData list = snapshot.data;
                                return ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (context, index){
                                    return Column(
                                      children: <Widget>[
                                        Text('JUMLAH KASUS', style: TextStyle(letterSpacing: 1.0, fontWeight: FontWeight.bold),),
                                        SizedBox(height: 40,),
                                        Text(list.listdata.first.totalkasus, style: TextStyle(letterSpacing: 2.0, fontWeight: FontWeight.bold),)
                                      ],
                                    );
                                  },
                                );
                              }
                              else{
                                return Container(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red,
                        spreadRadius: 1,
                        offset: Offset(-2,2)
                      )
                    ]
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 120,
                  width: 180,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: FutureBuilder(
                            future: ConnectToAPI.APIdataTotalINDONESIA(),
                            builder: (context, snapshot){
                              if(snapshot.hasData){
                                ListData list = snapshot.data;
                                return ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (context, index){
                                    return Column(
                                      children: <Widget>[
                                        Text('JUMLAH SEMBUH', style: TextStyle(letterSpacing: 1.0, fontWeight: FontWeight.bold),),
                                        SizedBox(height: 40,),
                                        Text(list.listdata.first.totalsembuh, style: TextStyle(letterSpacing: 2.0, fontWeight: FontWeight.bold),)
                                      ],
                                    );
                                  },
                                );
                              }
                              else{
                                return Container(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.red,
                            spreadRadius: 1,
                            offset: Offset(-2, 2)
                        )
                      ]
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: Text('RUMAH SAKIT RUJUKAN', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 15),),
                  ),
                  Container(
                    child: IconButton(icon: Icon(Icons.arrow_forward), onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HalamanRumahSakit()));
                    }, color: Colors.blue,),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              height: 180,
              width: 350,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: FutureBuilder(
                        future: ConnectToAPI.APIrumahsakitINDONESIA(),
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            ListRS listrs = snapshot.data;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(listrs.listrumahsakit[16].namarumahsakit, style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 16),),
                                SizedBox(height: 5,),
                                Text(listrs.listrumahsakit[16].daerah, style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 16)),
                                SizedBox(height: 5,),
                                Text(listrs.listrumahsakit[16].notelp, style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 16)),
                                SizedBox(height: 5,),
                                Text(listrs.listrumahsakit[16].alamat),


                              ],
                            );
                          }else{
                            return Container(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                          ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange,
                  )
                ]
              ),
            ),
          ],
        )
      )
    );
  }
}
