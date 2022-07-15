//
//  SideMenuView.swift
//  My Project
//
//  Created by ANGUS HILTON on 28/01/2021.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isshowing:Bool
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                //header
                SideMenuHeaderView(isshowing:$isshowing)
                    .foregroundColor(.white)
                    .frame(height:140)
                //cells
                ForEach(0..<3){_ in
                    SideMenuOptionView()
                }
                Spacer()
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isshowing: .constant(true))
    }
}
