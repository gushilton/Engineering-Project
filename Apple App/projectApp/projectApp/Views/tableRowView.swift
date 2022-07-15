//
//  tableRow.swift
//  projectApp
//
//  Created by ANGUS HILTON on 07/09/2021.
//

import SwiftUI

struct tableRowView: View {
    var Task:Task
    var body: some View {        
        NavigationLink(destination:TaskInfoView(Task:Task)) {
            HStack(spacing:50){
                Text(Task.Job_ID)
                    .frame(width: 30.0)
                Text(Task.AssignedTo)
                    .frame(width: 100.0)
                Text(Task.Set_Date)
                    .frame(width: 100.0)
                Text(Task.Due_Date)
                    .frame(width: 100.0)
                Text(Task.Complete_Date)
                    .frame(width: 100.0)
                Image(systemName: Bool(Task.Complete) ?? false ? "checkmark.square":"square")
                
            }
        }
    }
}

struct tableRow_Previews: PreviewProvider {
    static var previews: some View {
        tableRowView(Task: testData1)
    }
}
