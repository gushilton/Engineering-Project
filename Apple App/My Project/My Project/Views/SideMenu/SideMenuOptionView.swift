//
//  SideMenuOptionView.swift
//  My Project
//
//  Created by ANGUS HILTON on 28/01/2021.
//

import SwiftUI

struct SideMenuOptionView: View {
    var body: some View {
        HStack{
            Image(systemName:"person")
                .frame(width:24,height:24)
            Text("Profile")
            Spacer()
        }
        .foregroundColor(.white)
        .padding()
    }
}

struct SideMenuOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptionView()
    }
}
