//
//  ContentView.swift
//  projectApp
//
//  Created by ANGUS HILTON on 07/09/2021.
//

import SwiftUI

struct ContentView: View {
    @State var username:String = UserDefaults.standard.string(forKey: usernameKey) ?? ""
    @State var password:String = UserDefaults.standard.string(forKey: passwordKey) ?? ""
    @State var serverADR:String = UserDefaults.standard.string(forKey: serverAdrKey) ?? ""
    @State var Loginshowing:Bool = UserDefaults.standard.bool(forKey: loggedInKey)
    @State var filterShowing = false
    var body: some View {
        NavigationView{
            HStack(){
                if (!Loginshowing){
                    LoginView(loginShowin: $Loginshowing)
                    }
                else{
                    if (filterShowing){
                        filtersView(filterShowing:  $filterShowing)
                    }else{
                        ExtractedView(Tasks: testData)
                    }
                }
            }.toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button("S"){
                        Loginshowing.toggle()
                    }}
                    ToolbarItem(placement: .navigationBarLeading){
                        Button("F"){
                        filterShowing.toggle()
                        }
                    }
                }
                
            }
        }
        
    }



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ExtractedView: View {
    @State var Tasks:[Task]
    var body: some View {
        ScrollView([.horizontal, .vertical ]){
            ForEach(Tasks,id:\.Job_ID){
                Task in
                tableRowView(Task: Task)
            }
        }
        //.navigationBarHidden(true)
        .onAppear {
            networkManager().getTasks {
                (tasks) in
                self.Tasks = tasks
            }
        }
    }
}
