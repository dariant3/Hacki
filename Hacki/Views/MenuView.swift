//
//  MenuView.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-20.
//

import SwiftUI
import FirebaseAuth

struct MenuView: View {
    @EnvironmentObject var vm: LoginViewModel

    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .imageScale(.large)
                Text("Logout")
                    .font(.headline)
            }
            .onTapGesture {
                vm.signOut()
                vm.loginStatus = ""
                HackiApp()
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth:.infinity,alignment: .leading)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
