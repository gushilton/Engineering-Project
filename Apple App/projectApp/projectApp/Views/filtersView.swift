//
//  filtersView.swift
//  projectApp
//
//  Created by ANGUS HILTON on 14/09/2021.
//

import SwiftUI


struct filtersView: View {
    
    enum sortby: String, CaseIterable, Identifiable {
        case Job_ID
        case Date_Due
        case Date_Set
        case Date_Complete
        case Assigned_To
        var id: String { self.rawValue }
    }
    @State var Complete = UserDefaults.standard.bool(forKey: completeKey)
    @State var AssignedTo = UserDefaults.standard.bool(forKey: AssignedToKey)
    @State var selectsortBY = sortby.Job_ID
    @State var orderASC = UserDefaults.standard.bool(forKey: orderkey)
    @Binding var filterShowing:Bool
    
    var body: some View {
        VStack {
            VStack {
                Text("Filters")
                Toggle(isOn: $Complete, label: {
                    Text("Complete")
                })
                Toggle(isOn: $AssignedTo, label: {
                    Text("Assigned to Me")
                })
            }
            
            Picker("Sort By:",selection: $selectsortBY) {
                ForEach(sortby.allCases){sort in
                    Text(sort.rawValue.replacingOccurrences(of: "_", with: " ")).tag(sort)
                        
                }
            }
            
            Toggle(isOn: $orderASC, label: {
                Text("Ascending Order")
            })
                
            Button("Update filter") {
                UserDefaults.standard.set(selectsortBY.rawValue, forKey: sortbyKey)
                UserDefaults.standard.set(orderASC, forKey: orderkey)
                UserDefaults.standard.set(AssignedTo,forKey: AssignedToKey)
                UserDefaults.standard.set(Complete,forKey: completeKey)
                filterShowing.toggle()
                
            }
        }
    }
    
}

//struct filtersView_Previews: PreviewProvider {
//    static var previews: some View {
//        filtersView()
//    }
//}
