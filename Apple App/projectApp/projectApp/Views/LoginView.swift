//
//  LoginView.swift
//  projectApp
//
//  Created by ANGUS HILTON on 14/09/2021.
//

import SwiftUI
struct LoginView: View {
    @State var username:String = UserDefaults.standard.string(forKey: usernameKey) ?? ""
    @State var password:String = UserDefaults.standard.string(forKey: passwordKey) ?? ""
    @State var serverADR:String = UserDefaults.standard.string(forKey: serverAdrKey) ?? ""
    @State var btr = "Login"
    @State private var showingAlert = false
    @State var resp:String = ""
    @Binding var loginShowin:Bool
    var body: some View {
        VStack {
            Spacer()
            Text("username")
            TextField("username", text: $username)
                .autocapitalization(.none)
            Text("password")
            TextField("password", text: $password)
                .autocapitalization(.none)
            Text("Server Adress")
            TextField("server", text: $serverADR)
                .autocapitalization(.none)
            Spacer()
            Button(action: {
                networkManager().Login(username: username, password: password, server: serverADR) {
                    response in
                    resp = response
                    showingAlert = true
                    
                    }
                }, label: {
                Text(btr)
                }).alert(isPresented: $showingAlert, content: {
                    Alert(
                        title: Text("login attempt"),
                        message: Text(resp),
                        dismissButton: .default(Text("OK!"),action: {
                            if resp == "Logged in"{
                                loginShowin = UserDefaults.standard.bool(forKey: loggedInKey)
                            }
                        })
                    )
                })
        
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
       Text("")
    }
}
