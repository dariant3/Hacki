//
//  ProfileView.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-14.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack{
            VStack{
                Image("hackysack")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .topLeading)
                    .clipped()
                HStack{
                    Spacer()
                    Text("Darian Tichler")
                        .font(Font.title)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 240, alignment: .leading)
                }
            }
            Image("profile")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150, alignment: .leading)
                .clipped()
                .cornerRadius(75)
                .overlay(
                    RoundedRectangle(cornerRadius: 75)
                        .stroke(Color.white, lineWidth: 4)
                )
                .offset(x: -UIScreen.main.bounds.size.width/2+85, y: 90)
        }
        .offset(y: 0)
        .frame(minWidth: 0, maxHeight: UIScreen.main.bounds.size.height, alignment: .topLeading)
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
