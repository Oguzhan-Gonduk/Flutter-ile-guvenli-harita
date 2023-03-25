import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/community_center_model.dart';

class Community extends StatefulWidget {
  Community({Key? key}) : super(key: key);

  @override
  _Community createState() => _Community();
}

class _Community extends State<Community> {
  late Future<CommunityCenter> futureData;
  var dropdownvalue;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, AsyncSnapshot<CommunityCenter> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.connectionState == ConnectionState.done) {
            debugPrint("****başarıyla baglanıldı");
            return Container(
              height: 100,
              width: double.infinity,
              alignment: Alignment.center,
              child: DropdownButton(
                icon: const Icon(Icons.arrow_downward),
                hint: Text('Adresler'),
                items: snapshot.data?.result.map((item) {
                  return DropdownMenuItem(
                    value: item.name.toString(),
                    child: Text(item.name.toString()),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    dropdownvalue = newVal;
                  });
                },
                value: dropdownvalue,
              ),
            );
          }
          else {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
        },
      ),
    );
  }
}

Future<CommunityCenter> fetchData() async {
  String url = 'https://api.guvenliharita.com/api/services/app/CommunityCenter/GetAllForCity?cityId=63';
  final response =
  await http.get(Uri.parse(url));
  var result = json.decode(response.body);
  var _CommunityCenter = CommunityCenter.fromJson(result);
  return _CommunityCenter;

}