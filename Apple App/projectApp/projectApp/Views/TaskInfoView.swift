//
//  TaskInfo.swift
//  projectApp
//
//  Created by ANGUS HILTON on 07/09/2021.
//

import SwiftUI

struct TaskInfoView: View {
    let Task:Task
    @State var alertShowing:Bool = false
    @State var alertMSG:String = ""
    
    var body: some View {
        VStack {
            Text("Job ID:  \(Task.Job_ID)")
            Text("Assigned To :\(Task.AssignedTo)")
            Text(Task.Set_Date)
            Text(Task.Due_Date)
            Text("Date Complete: \(Task.Complete_Date)")
            HStack {
                Text("Task Completed: ")
                Image(systemName: Bool(Task.Complete) ?? false ? "checkmark.square":"square")
            }
            Button("Update") {
                networkManager().update(JobID: Task.Job_ID) { response in
                    alertMSG = response
                    alertShowing = true
                }
            }
            .alert(isPresented: $alertShowing, content: {
                Alert(title: Text(""), message: Text(alertMSG), dismissButton: .default(Text("OK")))
            })
            
            
            
        }
    }
}

struct TaskInfo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskInfoView(Task: testData1)
            
        }
    }
}
