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
    @EnvironmentObject var vm: LoginViewModel
    
    var body: some View {
            if vm.isSignedIn {
                MainView()
            }
            else {
                SignInView()
            }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
