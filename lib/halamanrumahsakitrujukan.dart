import 'package:covid19apps/restservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HalamanRumahSakit extends StatefulWidget {
  @override
  _HalamanRumahSakitState createState() => _HalamanRumahSakitState();
}

class _HalamanRumahSakitState extends State<HalamanRumahSakit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DAFTAR RUMAH SAKIT', style: TextStyle(color: Colors.black, letterSpacing: 1.0),),
        centerTitle: true,
        actions: <Widget>[
          Container(padding: EdgeInsets.symmetric(horizontal: 5),child: IconButton(icon: Icon(Icons.search), onPressed: (){
            showSearch(context: context, delegate: DataSearch());
          }, color: Colors.black,)),
        ],
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: FutureBuilder(
          future: ConnectToAPI.APIrumahsakitINDONESIA(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              ListRS listrs = snapshot.data;
              return ListView.builder(
                itemCount: listrs.listrumahsakit.length,
                itemBuilder: (context, index){
                  return Column(
                    children: <Widget>[
                      SizedBox(height: 10,),
                      // RaisedButton(onPressed: ()async{
                      //   var result = await ConnectToAPI.APIrumahsakitINDONESIA();
                      //   print(result.listrumahsakit.length.toString());
                      // },child: Text('api'),),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        height: 180,
                        width: 350,
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(listrs.listrumahsakit[index].namarumahsakit, style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 16),),
                            SizedBox(height: 5,),
                            Text(listrs.listrumahsakit[index].daerah, style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 16)),
                            SizedBox(height: 5,),
                            Text(listrs.listrumahsakit[index].notelp==null? '-': listrs.listrumahsakit[index].notelp, style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 16)),
                            SizedBox(height: 5,),
                            Text(listrs.listrumahsakit[index].alamat),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          border: Border.all(color: Colors.red),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red,
                              offset: Offset(-3, 4),
                            ),
                          ]
                        ),
                      )
                    ],
                  );
                },
              );
            } else{
              return Container(
                alignment: Alignment.center,
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
      future: ConnectToAPI.APIrumahsakitINDONESIA(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          ListRS listrs = snapshot.data;
          final list = listrs.listrumahsakit.where((element) => element.daerah.toLowerCase().contains(query.toLowerCase()) || element.namarumahsakit.toLowerCase().contains(query.toLowerCase())).toList();
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index){
              return Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 200,
                      width: 350,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(list[index].namarumahsakit, style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 16),),
                          SizedBox(height: 5,),
                          Text(list[index].daerah, style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 16)),
                          SizedBox(height: 5,),
                          Text(list[index].notelp==null? '-': list[index].notelp, style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 16)),
                          SizedBox(height: 5,),
                          Text(list[index].alamat),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          border: Border.all(color: Colors.red),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.red,
                                offset: Offset(-5, 5)
                            )
                          ]
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
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
    // show result search
    // final listkota = query.isEmpty?kotasearch: kota.where((element) => element.startsWith(query)).toList();
    return FutureBuilder(
      future: ConnectToAPI.APIrumahsakitINDONESIA(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          ListRS seluruhrumahsakitrujukan = snapshot.data;
          final listrs = query.isEmpty? null : seluruhrumahsakitrujukan.listrumahsakit.where((element) => element.namarumahsakit.toLowerCase().contains(query.toLowerCase()) || element.daerah.toLowerCase().contains(query.toLowerCase())).toList();
          return query.isEmpty ? Center(child: Text('isi dulu'),) : ListView.builder(
            itemCount: listrs.length,
            itemBuilder: (context, index){
              return Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 200,
                      width: 350,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(listrs[index].namarumahsakit, style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 16),),
                          SizedBox(height: 5,),
                          Text(listrs[index].daerah, style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 16)),
                          SizedBox(height: 5,),
                          Text(listrs[index].notelp==null? '-': listrs[index].notelp, style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 16)),
                          SizedBox(height: 5,),
                          Text(listrs[index].alamat),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        border: Border.all(color: Colors.red),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red,
                            offset: Offset(-5, 5)
                          )
                        ]
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
    );
    throw UnimplementedError();
  }
  
}
