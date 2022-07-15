//
//  networkManager.swift
//  projectApp
//
//  Created by ANGUS HILTON on 09/09/2021.
//

import Foundation
struct responsetest:Codable{
    var status:String
}
let rowNames:Task = Task(Job_ID: "Job ID", Maintenance_ID: "Maintenance ID", Job_Name: "Job Name", AssignedTo: "Assigned To", Complete_Date: "Complete Date", Set_Date: "Set Date", Due_Date: "Due Date", Complete: "Complete")


class networkManager{
    
    
    func getTasks(completion: @escaping ([Task]) -> ()){
        let username:String = UserDefaults.standard.string(forKey: usernameKey) ?? ""
        let password:String = UserDefaults.standard.string(forKey: passwordKey) ?? ""
        let serverADR:String = UserDefaults.standard.string(forKey: serverAdrKey) ?? ""
        let sortby:String = UserDefaults.standard.string(forKey: sortbyKey) ?? "Job_ID"
        let orderby:Bool = UserDefaults.standard.bool(forKey: orderkey)
        let filter_complete:Bool = UserDefaults.standard.bool(forKey: completeKey)
        let filter_Assigned:Bool = UserDefaults.standard.bool(forKey: AssignedToKey)
        
        let filter:[String:String] = ["complete":String(filter_complete),"AssignedMe":String(filter_Assigned)]
        let sort:[String:String] = ["sortby":sortby,"orderby":orderby ? "DESC" : "ASC"]
        if serverADR != ""{
            guard let url1 = URL(string: "http://\(serverADR)/Task/get_Tasks.php") else {    return  }
            let body:[String:Any] = ["username":username,"password":password,"sort":sort,"filters":filter]
            let sendbody = try! JSONSerialization.data(withJSONObject: body)
            
            var request = URLRequest(url: url1)
            request.httpMethod="POST"
            request.httpBody = sendbody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            URLSession.shared.dataTask(with: request) {
                dta, respnse, error in
                
                if let data = dta{
                    
                    if let TasksJSON = try? JSONDecoder().decode(TasksInfo.self, from: data){
                        var rtn = TasksJSON.tasks
                        rtn.insert(rowNames, at: 0)
                        DispatchQueue.main.async {
                            completion(rtn)
                            
                        }
                        return
                    }
                }
                print(error?.localizedDescription ?? "error uknown")
            }.resume()
            
        }
    }
    func update(JobID:String, completion: @escaping (String) -> ()) {
        let username:String = UserDefaults.standard.string(forKey: usernameKey) ?? ""
        let password:String = UserDefaults.standard.string(forKey: passwordKey) ?? ""
        let serverADR:String = UserDefaults.standard.string(forKey: serverAdrKey) ?? ""
        let body:[String:String] = ["username":username,"password":password,"Job_ID":JobID]
        let sendbody = try! JSONSerialization.data(withJSONObject: body)
        guard let updateURL = URL(string: "http://\(serverADR)/Task/update_Task.php") else{
           completion("invalid url")
            return
        }
        var request = URLRequest(url: updateURL)
        request.httpMethod="POST"
        request.httpBody = sendbody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: request) {
            dataResponse, respnse, error in
            if let data = dataResponse{
                if let r = try? JSONDecoder().decode(responsetest.self, from: data){
                    
                        completion(r.status)
                    return
                    
                }
                
            }
            completion("error:\(error?.localizedDescription ?? "uknown")")
        }.resume()
    }
    
    func Login(username:String,password:String,server:String, completion: @escaping (String) -> ()){
        guard let loginURL = URL(string: "http://\(server)/DB_test.php") else{
            completion("url unsucsessful")
            return
        }
        let body:[String:String] = ["username":username,"password":password]
        let sendbody = try! JSONSerialization.data(withJSONObject: body)
        
        var loginrequest = URLRequest(url: loginURL)
        loginrequest.httpMethod="POST"
        loginrequest.httpBody = sendbody
        loginrequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        loginrequest.setValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: loginrequest) { dataResponse, response, error in
            if let data = dataResponse{
                if let r = try? JSONDecoder().decode(responsetest.self, from: data){
                    if r.status == "logged in"{
                        UserDefaults.standard.set(username, forKey: usernameKey)
                        UserDefaults.standard.set(password, forKey: passwordKey)
                        UserDefaults.standard.set(server, forKey: serverAdrKey)
                        UserDefaults.standard.set(true, forKey: loggedInKey)
                        DispatchQueue.main.async {
                            completion("Logged in")
                        }
                    }else{
                        UserDefaults.standard.set(false, forKey: loggedInKey)
                        DispatchQueue.main.async {
                            completion("Login Failed")
                        }
                    }
                    return
                }
                
            }
            completion("error: \(error?.localizedDescription ?? "unknown")")
        }.resume()
    }
}
