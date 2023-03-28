import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/city_model.dart';
import 'community_center_screen.dart';

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
       body:FutureBuilder(
            future: fetchData(),
            builder: (context, AsyncSnapshot<City> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
            }
            else if (snapshot.connectionState == ConnectionState.done) {
            return Container(
                  margin:  EdgeInsets.symmetric(vertical: 50),
                  child: Column(
                    children: [
                      Container(
                        margin:  EdgeInsets.symmetric(vertical: 20),
                        height: 250,
                        width: 250,
                        child: Image.asset("assets/logo.png"),
                      ),
                      Column(
                        children: [
                          Container(
                            child: Text("Şehrindeki Güvenli Toplanma Alanlarını Bul",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25), textAlign: TextAlign.center,),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            margin:  EdgeInsets.symmetric(horizontal: 30),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                                        blurRadius: 5) //blur radius of shadow
                                    ]
                                ),
                                child: DropdownButton(
                                  isExpanded: true,
                                  icon: const Icon(Icons.arrow_downward),
                                  underline: Container(),
                                  dropdownColor: Colors.white,
                                  style: TextStyle(fontSize: 14, color: Colors.black),
                                  hint: Text('Şehirler'),
                                  value: dropdownvalue,
                                  items: snapshot.data?.result.map((item) {
                                    return DropdownMenuItem(
                                      value: item.id,
                                      child: Text(item.name, textAlign: TextAlign.center,),
                                    );
                                  }).toList(),
                                  onChanged: (newVal) {
                                    setState(() {
                                      dropdownvalue = newVal;
                                    });
                                  },
                                ),
                              ),
                          ),
                          SizedBox(height: 20,),
                          SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                  primary: Colors.green),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Community(cityId: dropdownvalue,)),
                                );
                              },
                              child: const Text('Bul'),
                            ),
                          ),
                        ],
                      ),
                    ],
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