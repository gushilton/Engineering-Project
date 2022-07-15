//
//  tableRow.swift
//  My Project
//
//  Created by ANGUS HILTON on 07/09/2021.
//

import SwiftUI

struct tableRow: View {
    @State var Job_ID = ""
    @State var Assigned = ""
    @State var Date_set = ""
    @State var Date_due = ""
    @State var Date_complete = ""
    //@State var:Bool complete = false
    var body: some View {
        
        Button(action: {
            
        }, label: {
            HStack(spacing:50){
                Text(Job_ID)
                Text(Assigned)
                Text(Date_set)
                Text(Date_due)
                Text(Date_complete)
                Text("complete")
                }
            
        })
            
        
    }
}

struct tableRow_Previews: PreviewProvider {
    static var previews: some View {
        tableRow()
            .$Job_ID = "Job ID"
            
    }
}
