//
//  pickertest.swift
//  My Project
//
//  Created by ANGUS HILTON on 15/09/2021.
//

import SwiftUI


struct pickertest: View {
    
    enum sortby: String, CaseIterable, Identifiable {
        case Job_ID
        case Date_Due
        var id: String { self.rawValue }
    }

    @State private var selectedsortBy = sortby.Job_ID
    @State var btrText = "BTR"
    var body: some View {
       

        VStack {
            Picker("Sort By", selection: $selectedsortBy) {
              ForEach(sortby.allCases) { sortOption in
                Text(sortOption.rawValue).tag(sortOption)
              }
            }
            Button(btrText) {
                btrText = selectedsortBy.rawValue
            }
        }
        
    }
}

struct pickertest_Previews: PreviewProvider {
    static var previews: some View {
        pickertest()
    }
}
