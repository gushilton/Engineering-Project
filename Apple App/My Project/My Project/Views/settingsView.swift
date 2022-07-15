//
//  settingsView.swift
//  My Project
//
//  Created by ANGUS HILTON on 27/01/2021.
//

import SwiftUI

struct settingsView: View {
    @State var username:String = UserDefaults.standard.string(forKey: "username") ?? ""
    @State var password:String = UserDefaults.standard.string(forKey: "password") ?? ""
    @State var server:String = UserDefaults.standard.string(forKey: "server") ?? ""
    
    var body: some View {
        VStack{
            Text("Username")
                .padding()
            TextField("Username",text: $username)
                .padding()
            Text("Password")
                .padding()
            TextField("Password",text: $password)
                .padding()
                .textContentType(.password)
            Text("Server")
                .padding()
            TextField("Server",text: $server)
                .padding()
            Button("Login"){
                UserDefaults.standard.set(username, forKey: "username")
                UserDefaults.standard.set(password, forKey: "password")
                UserDefaults.standard.set(server, forKey: "server")
            }
            Spacer()
        }
    }
}
struct settingsView_Previews: PreviewProvider {
    static var previews: some View {
        settingsView()
    }
}

