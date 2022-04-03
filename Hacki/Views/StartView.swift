//
//  ContentView.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-13.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift



struct StartView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    
    var body: some View {
        NavigationView{
            if loginVM.isSignedIn {
                MainView()
            }
            else {
                SignInView()
            }
        }
//        .onAppear{
//            loginVM.signedIn = loginVM.isSignedIn
//        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
