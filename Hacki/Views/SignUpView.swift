//
//  SignUpView.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-22.
//

import SwiftUI

struct SignUpView: View {
    @State var email = ""
    @State var password  = ""
    
    @ObservedObject private var vm: LoginViewModel = LoginViewModel()
    
    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            VStack{
                TextField("Email Address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background()
                    .cornerRadius(15)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background()
                    .cornerRadius(15)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                Button(action: {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    vm.signUp(email: email, password: password)
                }, label: {
                    Text("Create Account")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(Color.accentColor)
                        .cornerRadius(15)
                })
                Text(vm.loginStatus)
                    .foregroundColor(.red)
            }
            .padding()
        }
        
    }
}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
