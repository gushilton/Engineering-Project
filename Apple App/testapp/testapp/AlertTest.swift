//
//  AlertTest.swift
//  testapp
//
//  Created by ANGUS HILTON on 14/09/2021.
//

import SwiftUI

struct AlertTest: View {
    @State var alertShowing:Bool = false
    @State var btr = "Show Alert"
    var body: some View {
        Button(btr) {
                   alertShowing = true
               }
               .alert(isPresented: $alertShowing) {
                Alert(
                    title: Text("Alert"),
                    dismissButton: .default(Text("OK!"), action: {
                        btr = "Alert showed"
                    })
                )
               }
           }
}

struct AlertTest_Previews: PreviewProvider {
    static var previews: some View {
        AlertTest()
    }
}
