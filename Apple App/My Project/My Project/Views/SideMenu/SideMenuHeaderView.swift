//
//  SideMenuHeaderView.swift
//  My Project
//
//  Created by ANGUS HILTON on 28/01/2021.
//

import SwiftUI

struct SideMenuHeaderView: View {
    @Binding var isshowing:Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button(action: {
                isshowing.toggle()
            }, label: {
                Image(systemName: "xmark")
                    .frame(width: 32, height: 32)
                    .foregroundColor(.white)
                    .padding()
            })
            VStack (alignment: .leading){
                Image("headerIm")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipped()
                    .clipShape(Circle())
                
                Text("Settings")
                    .font(.system(size: 24, weight: .bold))
                
                HStack{
                    Spacer()
                }
                Spacer()
            }.navigationBarHidden(true)
        }
        
    }
}

struct SideMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuHeaderView(isshowing: .constant(true))
    }
}
