//
//  ContentView.swift
//  My Project
//
//  Created by ANGUS HILTON on 02/02/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var Username:String = UserDefaults.standard.string(forKey: "username") ?? ""
    @State private var Password:String = UserDefaults.standard.string(forKey: "password") ?? ""
    @State private var Server:String = UserDefaults.standard.string(forKey: "server") ?? ""
    
    @State private var settingShowing:Bool = true
    
    
    var body: some View {
        NavigationView(){
            HStack{
                if (settingShowing){
                    settingsView()
                }else{
                    if (Username == "" || Server == ""){
                        settingsView()
                    }else{
                        TasksView()
                        
                    }
                }
            }.navigationBarItems(leading: Button(action: {
                    withAnimation(.spring()){
                        settingShowing.toggle()
                    }
                }, label: {
                Image(systemName: "list.bullet")
                    .foregroundColor(.black)
                }))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
