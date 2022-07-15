//
//  TasksView.swift
//  My Project
//
//  Created by ANGUS HILTON on 03/02/2021.
//

import SwiftUI

struct TasksView: View {
    
    @State var tasks:[taskInfo] = [taskInfo(Job_ID: "0", Assigned_TO: "", Set_Date: "",Due_Date: "",Complete_Date: "")]
    @State var taskID: Bool = false
    var body: some View {
        ScrollView([.horizontal,.vertical],showsIndicators: false){
            VStack(spacing:20){
                HStack(spacing:50){
                    Text("Job ID")
                        .multilineTextAlignment(.center)
                        .frame(width:60)
                    Text("Assigned To")
                        .frame(width:110)
                    Text("Due Date")
                        .frame(width:100)
                    Text("Set Date")
                        .frame(width:100)
                    Text("Complete Date")
                        .frame(width:120)
                }
                ForEach(tasks,id:\.Job_ID){Task in
                    HStack(spacing:50){
                        Text(Task.Job_ID)
                            .frame(width:60)
                            .multilineTextAlignment(.center)
                        Text(Task.Assigned_TO)
                            .frame(width:110)
                        Text(Task.Due_Date)
                            .frame(width:100)
                        Text(Task.Set_Date)
                            .frame(width:100)
                        Text(Task.Complete_Date)
                            .frame(width:120)
                    }
                }
                
            }.onAppear(){
                NetworkManager().getPost { (tasks) in
                    self.tasks = tasks
                }
            }
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
