import 'package:covid19apps/global/globalrestservices.dart';
import 'package:flutter/material.dart';

class GlobalCountryPage extends StatefulWidget {
  @override
  _GlobalCountryPageState createState() => _GlobalCountryPageState();
}

class _GlobalCountryPageState extends State<GlobalCountryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('DAFTAR NEGARA', style: TextStyle(letterSpacing: 1.0),),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: FutureBuilder(
            future: ConnectToAPIGLOBAL.APIglobal(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  ListCountry data = snapshot.data;
                  return ListView.builder(
                    itemCount: data.list.length,
                    itemBuilder: (context, index){
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          children: <Widget>[
                            Text(data.list[index].data.countryname.toUpperCase(), style: TextStyle(letterSpacing: 2.0, fontWeight: FontWeight.bold),),
                            SizedBox(height: 25,),
                            Column(
                              children: <Widget>[
                                Text(data.list[index].data.positif == 'null' ? 'POSITIF : TIDAK ADA DATA' : 'POSITIF : ' + data.list[index].data.positif, style: TextStyle(letterSpacing: 1.0),),
                                SizedBox(height: 10,),
                                Text(data.list[index].data.sembuh == 'null' ? 'SEMBUH : TIDAK ADA DATA' : 'SEMBUH : ' + data.list[index].data.sembuh, style: TextStyle(letterSpacing: 1.0),),
                                SizedBox(height: 10,),
                                Text(data.list[index].data.meninggal == 'null' ? 'MENINGGAL : TIDAK ADA DATA' : 'MENINGGAL : ' + data.list[index].data.meninggal, style: TextStyle(letterSpacing: 1.0),),
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
                          ],
                        ),
                      );
                    },
                  );
                  }else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
            }
          ),
        ),
      ),
    );
  }
}
