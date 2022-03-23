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

class appViewModel: ObservableObject {
    //@EnvironmentObject var viewModel: UserViewModel
    
    let auth = Auth.auth()
    let db = Firestore.firestore()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool{
        return auth.currentUser != nil
    }
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password){ [weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            // Success
            print("Sign in")

            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password){[weak self] result, error in
            guard result != nil, error == nil else{
                print("\(email) and \(password)")
                print("\(error)")
                return
            }
            // Success
            // Create user in firestore
            var uid = self!.auth.currentUser!.uid
            //self!.viewModel.addUser(user: User(id:uid,name:"Weee",email: email))

            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signOut(){
        try? auth.signOut()
        self.signedIn = false
    }
}

struct ContentView: View {
    @EnvironmentObject var viewModel: appViewModel
    
    var body: some View {
        NavigationView{
            if viewModel.signedIn {
                MainView()
//                VStack{
//                    Text("You are signed in")
//                    Button(action: {viewModel.signOut()}, label: {
//                        Text("Sign Out")
//                            .frame(width: 200, height: 50)
//                            .background(Color.accentColor)
//                    })
//                }
            }
            else {
                SignInView()
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct SignInView: View {
    @State var email = ""
    @State var password  = ""
    
    @EnvironmentObject var viewModel: appViewModel
    
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
                    viewModel.signIn(email: email, password: password)
                }, label: {
                    Text("Sign in")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(Color.accentColor)
                        .cornerRadius(15)
                })
                NavigationLink("Create Account",destination: SignUpView())
            }
            .padding()
            
        }
        
    }
}

struct SignUpView: View {
    @State var email = ""
    @State var password  = ""
    
    @EnvironmentObject var viewModel: appViewModel
    
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
                    viewModel.signUp(email: email, password: password)
                }, label: {
                    Text("Create Account")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(Color.accentColor)
                        .cornerRadius(15)
                })
            }
            .padding()
            
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
