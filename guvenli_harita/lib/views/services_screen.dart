import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/city_model.dart';

class Services extends StatefulWidget {
  Services({Key? key}) : super(key: key);

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  var dropdownvalue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: FutureBuilder(
        future: fetchData(),
        builder: (context, AsyncSnapshot<City> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
        }
        else if (snapshot.connectionState == ConnectionState.done) {
        debugPrint("başarıyla baglanıldı");
        return Container(
          height: 100,
          width: double.infinity,
          alignment: Alignment.center,
          child: DropdownButton(
            icon: const Icon(Icons.arrow_downward),
            hint: Text('Şehirler'),
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

  Future<City> fetchData() async {
    const String url = 'https://api.guvenliharita.com/api/services/app/City/GetAllForComboBox?isAll=true';
    final response =
        await http.get(Uri.parse(url));
    var result = json.decode(response.body);
    var _city = City.fromJson(result);
    return _city;

  }