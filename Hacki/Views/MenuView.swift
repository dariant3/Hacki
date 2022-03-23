//
//  MenuView.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-20.
//

import SwiftUI
import FirebaseAuth

struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .imageScale(.large)
                Text("Logout")
                    .font(.headline)
            }
            .onTapGesture {
                signOut()
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth:.infinity,alignment: .leading)
    }
}

func signOut(){
    do{
        try Auth.auth().signOut()
        
    } catch let err{
        print(err)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
