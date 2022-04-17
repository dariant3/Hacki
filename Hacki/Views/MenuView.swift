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
    @EnvironmentObject var lvm: LocationViewModel

    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .imageScale(.large)
                Text("Logout")
                    .font(.headline)
            }
            .onTapGesture {
                lvm.toggleVisibility(vis: false)
                vm.signOut()
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
