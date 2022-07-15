//
//  NetworkManager.swift
//  My Project
//
//  Created by ANGUS HILTON on 02/02/2021.
//
import Foundation
import SwiftUI
import Combine


class NetworkManager {
    private let Username:String = UserDefaults.standard.string(forKey: "username") ?? ""
    private let Password:String = UserDefaults.standard.string(forKey: "password") ?? ""
    private let Server:String = UserDefaults.standard.string(forKey: "server") ?? ""
    

    func getPost(completion: @escaping ([taskInfo]) -> ()) {
        guard  let url = URL(string: "http://\(Server)/getTasks.php") else {return}
        let body:[String:String] = ["username":Username,"password":Password]
        guard let httpbody = try? JSONSerialization.data(withJSONObject: body)else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpbody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){
            (data,_,_)  in
            let task = try! JSONDecoder().decode(taskGet.self, from: data!)
            DispatchQueue.main.async {
                completion(task.tasks)
            }
        }.resume()
    }
}
