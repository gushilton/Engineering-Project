import 'package:http/http.dart';
import 'dart:convert';


class GetData{
  String url;
  String username;
  String password;
  Map<String,String> header = {"Content-Type":"application/json;charset=UTF-8","Charset":"utf-8"};

  GetData({required this.password,required this.username,required this.url});

  Future<Map> homeData() async{
    DateTime today = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
    DateTime week = today.add(Duration(days: 7));
    Map homeResult = {};
    try {
      Map<String, String> body = {"username": username, "password": password,"todayDate":today.toString().substring(0,10), "weekDate":week.toString().substring(0,10)};
      Response response = await post(
          Uri.parse(url), headers: header, body: jsonEncode(body));
      if (response.statusCode == 200){
        Map data = jsonDecode(response.body);
        if (data["status"]== "success"){
          homeResult = data["result"];
        }else if(data["status"]== "failed"){
          throw new Exception("Failed to login :${data["reason"]}");
        }else{
          throw new Exception("Error login");
        }
      }else{
        throw new Exception("Error connecting to Server :${response.statusCode}");
      }

    }catch(exception){
      throw Future.error(exception);
    }finally{
      return homeResult;
    }
  }

  Future<Map<dynamic,dynamic>> login() async {
    Map<dynamic,dynamic> data = {};
    try{
      Map<String,String> body = {'username':username, "password": password};
      Response response = await post(Uri.parse(url),headers:header,body: jsonEncode(body));
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        String status = data['dbStatus'];
        if (status == "success"){
          return data["userInfo"];
        }else{
          return Future.error("Login Failed:\n${data["reason"]}");

        }
      }else{
        return Future.error("Failed to connect to server:\n${response.statusCode}");
      }

    }catch(exception){
      return Future.error(exception);
    }
  }
  
  Future<Map<String,dynamic>> getHeirachy() async{
    Map<String,dynamic> resultData = {};
    List<String> rows = [];
    try{
      Map<String,String> body = {'username':username, "password": password};
      Response response = await post(Uri.parse(url),headers:header,body: jsonEncode(body));
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        if (data["status"] == "success"){
          resultData = data["results"];
        }else if (data["status"] == "failed"){
          Future.error("Login Failed:\n${data["reason"]}");
        }else{
          Future.error("error");
        }
      }else{
        Future.error("error");
      }
    }catch(exception){
      Future.error("error");
    }finally{
      return {"response":resultData};
    }
  }

  Future<dynamic> getFunctions(String function) async{
    var result;
    Map<String,String> body = {'username':username, "password": password,"function":function};
    Response response = await post(Uri.parse(url),headers:header,body: jsonEncode(body));
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if(responseData["status"] == "success"){
        result = responseData["result"];
      }else{
        Future.error("login failed");
      }
    }else{
      Future.error("Server not reached");
    }
    return result;
  }


  Future<Map> getWorkOrderData(yearId,JobID) async{
    Map data = {};
    try{
      Map<String,String> body = {'username':username, "password": password,"yearID":yearId.toString(),"JobID":JobID.toString()};
      Response response = await post(Uri.parse(url),headers: header,body: jsonEncode(body));
      if (response.statusCode == 200){
        var result = jsonDecode(response.body);
        if (result["status"]== "success"){
          data = result;
        }else if(result["status"] == "failed"){
          Future.error("failed to login:\n${result['response']}");
        }else{
          Future.error("error on server\ntry again");
        }
      }else{

        Future.error("failed to connect to server");
      }
    }catch(exception){
      var x= 1;

    }
    return data;

  }

  Future<Map> getFunctionData(heriachy,id) async{
    var result;
    try{
      Map<String,String> body = {'username':username, "password": password,"heirachy":heriachy.toString(),"function":id.toString()};
      Response response = await post(Uri.parse(url),headers: header,body: jsonEncode(body));
      if (response.statusCode == 200){
        var data = jsonDecode(response.body);
        if (data['status']== "success"){
          result = data['result'];
        }else if (data['status']== "failed"){
          Future.error("login failed");
        }else{
          Future.error("unknown reason failed");
        }

      }else{
        Future.error("failed to connect to server");
      }
    }catch(exception){
      Future.error("exception");
    }
    return result;
  }

 Future<Map> getWorkOrders()async{
    Map workOrders ={};
    try{
      Map<String,String> body = {'username':username, "password": password,"order":"ORDER BY Date_Due ASC, yearID ASC,JobID ASC"};
      Response response = await post(Uri.parse(url),headers: header,body: jsonEncode(body));
      if (response.statusCode == 200){
        var json = jsonDecode(response.body);
        if (json['status'] == "success"){
          workOrders = json;
        }else if (json['status']=="failed"){
          throw Exception("login failed\n${json['reason']}");
        }else{
          throw Exception("server error");
        }
      }else{
        throw Exception("Failed to connect to server");
      }
    }catch (e){
      Future.error(e);
    }

    return workOrders;
 }

  Future<Map> getRoles() async{
    Map result = {};
    try{
      Map<String,String> body = {'username':username, "password": password};
      Response response = await post(Uri.parse("http://${url}/getRoles.php"),headers: header,body: jsonEncode(body));
      if (response.statusCode == 200){
        var json = jsonDecode(response.body);
        if (json['status'] == "success"){
          result = json;
        }else if (json['status']=="failed"){
          throw Exception("login failed\n${json['reason']}");
        }else{
          throw Exception("server error");
        }
      }else{
        throw Exception("Failed to connect to server");
      }

    }catch(e){
      throw Future.error("error");
    }
    return result;
  }

  Future<Map> getDefects(department) async{
    Map result = {};
    try{
      Map<String,String> body = {'username':username, "password": password, "department":department};
      Response response = await post(Uri.parse(url),headers: header,body: jsonEncode(body));
      if (response.statusCode == 200){
        var json = jsonDecode(response.body);
        if (json['status'] == "success"){
          return json;
        }else if (json['status']=="failed"){
          throw Exception("login failed\n${json['reason']}");
        }else{
          throw Exception("server error");
        }
      }else{
        throw Exception("Failed to connect to server");
      }

    }catch(e){

    }
    return result;
  }

  Future<Map> updateWorkOrder(Map workOrder,String note,Map update) async {
    Map result = {};
    try{
      Map<String,dynamic> body = {'username':username, "password": password, "workOrder":workOrder,"Date":DateTime.now().toString().substring(0,10),"datetime":DateTime.now().toString().substring(0,19),"note":note,"update":update};
      Response response = await post(Uri.parse(url),headers: header,body: jsonEncode(body));
      if (response.statusCode == 200){
        var json = jsonDecode(response.body);
        if (json['status'] == "success"){
          result = json;
        }else if (json['status']=="failed"){
          throw Exception("login failed\n${json['reason']}");
        }else{
          throw Exception("server error");
        }
      }else{
        throw Exception("Failed to connect to server");
      }

    }catch(e){
      var x= e;

    }

    return result;
  }

  Future<dynamic> getTimeSheet()async{
    var prevWeek = DateTime.now().subtract(Duration(days: 7)).toString().substring(0,19);
    var prev24 = DateTime.now().subtract(Duration(hours: 24)).toString().substring(0,19);
    Map result = {};
    try{
      Map<String,dynamic> body = {'username':username, "password": password,"today":DateTime.now().toString().substring(0,19),"week":prevWeek,"time24":prev24};
      Response response = await post(Uri.parse(url),headers: header,body: jsonEncode(body));
      if (response.statusCode == 200){
        var json = jsonDecode(response.body);
        if (json['status'] == "success"){
          result = json;
        }else if (json['status']=="failed"){
          throw Exception("login failed\n${json['reason']}");
        }else{
          throw Exception("server error");
        }
      }else{
        throw Exception("Failed to connect to server");
      }

    }catch(e){
      var x= e;

    }

    return result;
  }
  Future<dynamic> clockIn()async{
    Map result = {};
    try{
      Map<String,dynamic> body = {'username':username, "password": password,"timeIn":DateTime.now().toString().substring(0,19),"Month":DateTime.now().toString().substring(5,7),"Year":DateTime.now().toString().substring(2,4)};
      Response response = await post(Uri.parse(url),headers: header,body: jsonEncode(body));
      if (response.statusCode == 200){
        var json = jsonDecode(response.body);
        if (json['status'] == "success"){
          result = json;
        }else if (json['status']=="failed"){
          throw Exception("login failed\n${json['reason']}");
        }else{
          throw Exception("server error");
        }
      }else{
        throw Exception("Failed to connect to server");
      }

    }catch(e){
      var x= e;

    }

    return result;

  }
  Future<dynamic> clockOut(timesheet)async{
    Map result = {};
    try{
      Map<String,dynamic> body = {'username':username, "password": password,"timeOut":DateTime.now().toString().substring(0,19),"timesheet":timesheet};
      Response response = await post(Uri.parse(url),headers: header,body: jsonEncode(body));
      if (response.statusCode == 200){
        var json = jsonDecode(response.body);
        if (json['status'] == "success"){
          result = json;
        }else if (json['status']=="failed"){
          throw Exception("login failed\n${json['reason']}");
        }else{
          throw Exception("server error");
        }
      }else{
        throw Exception("Failed to connect to server");
      }

    }catch(e){
      var x= e;

    }

    return result;

  }
  Future<dynamic> newWorkOrder(jobName,problem,action,dateDue,function)async{
    var result = {};

    try{
    Map<String,dynamic> body = {'username':username, "password": password,"DateCreated":DateTime.now().toString().substring(0,10),"problem":problem,"action":action,"function":function,"jobName":jobName,"DateDue":dateDue.toString().substring(0,10),"yearID":DateTime.now().toString().substring(2,4)};
    Response response = await post(Uri.parse(url),headers: header,body: jsonEncode(body));
    if (response.statusCode == 200){

      var json = jsonDecode(response.body);
      if (json['status'] == "success"){
        result = json;
      }else if (json['status']=="failed"){
        throw Exception("login failed\n${json['reason']}");
      }else{
        throw Exception("server error");
      }
    }else{
      print(response.statusCode);
      throw Exception("Failed to connect to server");
    }

  }catch(e){
  var x= e;

  }
  return result;
  }
}