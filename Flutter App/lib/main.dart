import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:myproject/classes/constants.dart';
import 'package:myproject/screens/pages/onfirstload.dart';
import 'screens/pages/main_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MyProjectAppConstants constants = MyProjectAppConstants();
  String keyString = "encriptionKey";
 await Hive.initFlutter();
 FlutterSecureStorage storage = FlutterSecureStorage();
  String? containsKey = await storage.read(key: keyString);
  if (containsKey == null){
    List<int> key = Hive.generateSecureKey();
    await storage.write(key: keyString, value: base64UrlEncode(key));
  }

    Uint8List encyriptionKey = base64Url.decode(await storage.read(key:keyString) as String);

  await Hive.openBox(constants.userBox,encryptionCipher: HiveAesCipher(encyriptionKey));
  await Hive.openBox(constants.filteringBox);
  Box userInfo = Hive.box(constants.userBox);
  if (userInfo.get(constants.usernameKey)==null){
    runApp(MaterialApp(
      home:OnFirstLoad()
    ));
  }else {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    ));
  }
}
