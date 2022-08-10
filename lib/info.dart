
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Info extends StatefulWidget {
  const Info({Key key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  String model = "";
  String deveiceVersion = "";
  String id = "";
  String brand = "";
  String display = "";
  String host = "";
  String realDev = "";
  String finger = "";

  Future<void> deveiceDetail() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        setState(() {
          model = build.model;
          deveiceVersion = build.version.sdkInt.toString();
          id = build.id;
          brand = build.brand;
          display = build.display;
          host = build.host;
          realDev = build.isPhysicalDevice.toString();
          finger = build.fingerprint;
        });
      } else if (Platform.isIOS) {
        var ios = await deviceInfoPlugin.iosInfo;
        setState(() {
          model = ios.model;
          deveiceVersion = ios.systemVersion.toString();
          realDev = ios.isPhysicalDevice.toString();
        });
      }else {
        print ("not android or ios");
      }
    } on PlatformException {
      print("ex");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DEVICE DETAIL APP WITH device_info"),
        centerTitle: true,

      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("model =:$model"),
            Text("deveiceVersion =: $deveiceVersion"),
            Text("id =: $id"),
            Text("brand =:$brand"),
            Text("display =:$display"),
            Text("host =:$host"),
            Text("realDev =:$realDev"),
            Text("finger =:$finger"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        deveiceDetail();
      },child: Icon(Icons.add),),
    );
  }
}
