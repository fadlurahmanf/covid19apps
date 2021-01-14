import 'package:covid19apps/restservices.dart';
import 'package:flutter/material.dart';

class DetailDataPerProvinsi extends StatefulWidget {
  @override
  _DetailDataPerProvinsiState createState() => _DetailDataPerProvinsiState();
}

class _DetailDataPerProvinsiState extends State<DetailDataPerProvinsi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('DATA PER PROVINSI'),
        centerTitle: true,
        actions: <Widget>[
          Container(padding: EdgeInsets.symmetric(horizontal: 5),child: IconButton(icon: Icon(Icons.search), onPressed: (){
            showSearch(context: context, delegate: DataSearch());
          },)),
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: ConnectToAPI.APIdatacovidtiapProvinsi(),
          builder: (context, snapshot){
            if (snapshot.hasData){
              DataCovidTiapProvinsi datacovidprovinsitiap_provinsi = snapshot.data;
              return ListView.builder(
                itemCount: datacovidprovinsitiap_provinsi.datacovidperprovinsitiap_provinsi.length,
                itemBuilder: (context, index){
                  return Column(
                    children: <Widget>[
                      SizedBox(height: 20,),
                      GestureDetector(
                        onTap: (){
                        },
                        child: Container(
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
                                alignment: Alignment.center,
                                height: 80,
                                child: Text(datacovidprovinsitiap_provinsi.datacovidperprovinsitiap_provinsi[index].kota, style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 20),),
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
                                        Text(datacovidprovinsitiap_provinsi.datacovidperprovinsitiap_provinsi[index].jumlah_kasus.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
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
                                        Text(datacovidprovinsitiap_provinsi.datacovidperprovinsitiap_provinsi[index].jumlah_meninggal.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
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
                                        Text(datacovidprovinsitiap_provinsi.datacovidperprovinsitiap_provinsi[index].jumlah_sembuh.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String>{
  @override
  List<Widget> buildActions(BuildContext context) {
    // action for appbar
    return[
      IconButton(icon: Icon(Icons.clear), onPressed: (){
        query = "";
      }),
    ];
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon in the left of the appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return FutureBuilder(
      future: ConnectToAPI.APIdatacovidtiapProvinsi(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          DataCovidTiapProvinsi datacovidtiap_provinsi = snapshot.data;
          final listdatacovidtiap_provinsi = query.isEmpty? null : datacovidtiap_provinsi.datacovidperprovinsitiap_provinsi.where((element) => element.kota.toLowerCase().contains(query.toLowerCase())).toList();
          return ListView.builder(
            itemCount: listdatacovidtiap_provinsi.length,
            itemBuilder: (context, index){
              return Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
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
                            alignment: Alignment.center,
                            height: 80,
                            child: Text(listdatacovidtiap_provinsi[index].kota, style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 20),),
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
                                    Text(listdatacovidtiap_provinsi[index].jumlah_kasus.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
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
                                    Text(listdatacovidtiap_provinsi[index].jumlah_meninggal.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
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
                                    Text(listdatacovidtiap_provinsi[index].jumlah_sembuh.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: ConnectToAPI.APIdatacovidtiapProvinsi(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          DataCovidTiapProvinsi datacovidtiap_provinsi = snapshot.data;
          final listdatacovidtiap_provinsi = query.isEmpty? null : datacovidtiap_provinsi.datacovidperprovinsitiap_provinsi.where((element) => element.kota.toLowerCase().contains(query.toLowerCase())).toList();
          return query.isEmpty? Center(child: Text(''),) : ListView.builder(
            itemCount: listdatacovidtiap_provinsi.length,
            itemBuilder: (context, index){
              return ListTile(
                onTap: (){
                  query = listdatacovidtiap_provinsi[index].kota;
                },
                title: Text(listdatacovidtiap_provinsi[index].kota, style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: -1),),
              );
            },
          );
        } else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
    throw UnimplementedError();
  }

}
