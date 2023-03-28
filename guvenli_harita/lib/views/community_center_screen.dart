import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import '../model/community_center_model.dart';
import 'current_locatiın_screen.dart';

class Community extends StatefulWidget {
  Community({Key? key, required this.cityId,}) : super(key: key);
  final int cityId;

  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  var dropdownvalue;
  int _cityId = 0;
  double _longitude = 0.0;
  double _latitude = 0.0;
  String _name = "null";

   @override
   void initState() {
    super.initState();
    _cityId =widget.cityId;
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Güvenli Bölgeler'),
        backgroundColor: Colors.green,
      ),
      body:FutureBuilder(
            future: fetchData(_cityId),
            builder: (context, snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                    itemCount: snapshot.data!.result.length ,
                    itemBuilder: (context, index){
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(snapshot.data!.result[index].name.toString()),
                              subtitle: Text(snapshot.data!.result[index].address),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.phone),
                                    onPressed: () {
                                      if(snapshot.data!.result[index].phoneNumber.toString() == null){
                                        FlutterPhoneDirectCaller.callNumber(snapshot.data!.result[index].phoneNumber.toString());
                                      }else{
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) => AlertDialog(
                                            title: Text(snapshot.data!.result[index].name.toString()),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text(snapshot.data!.result[index].authorizedPersonnel.toString()),
                                                  ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          textStyle: const TextStyle(fontSize: 20),
                                                          primary: Colors.green),
                                                      onPressed: () => FlutterPhoneDirectCaller.callNumber(snapshot.data!.result[index].phoneNumber.toString()),
                                                      child: Text(snapshot.data!.result[index].phoneNumber.toString(),style: TextStyle(fontWeight: FontWeight.bold))),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  icon: Icon(Icons.navigation),
                                  onPressed: () {
                                    _longitude = snapshot.data!.result[index].longitude!;
                                    _latitude = snapshot.data!.result[index].latitude!;
                                    _name = snapshot.data!.result[index].name!.toString();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => CurrentLocationScreen(longitudevalues: _longitude, latitudevalues:_latitude , name: _name,)),
                                      );
                                    },
                                  ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              }else if(snapshot.hasError){
                return Center(child: Text(snapshot.error.toString()),);
              }else{
                return const Center(child: CircularProgressIndicator(),);
              }
            },
          ),
          // Container(
          //      width: 500,
          //      height: 500,
          //      child: CurrentLocationScreen(),
          // )
    );
  }
}

Future<CommunityCenter> fetchData(int cityId) async {
  String url = 'https://api.guvenliharita.com/api/services/app/CommunityCenter/GetAllForCity?cityId=${cityId}';
  final response =
  await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    return CommunityCenter.fromJson(result);
  }else {
    throw Exception('Failed to load community center');
  }

}