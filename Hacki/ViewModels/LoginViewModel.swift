//
//  LoginViewModel.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-22.
//
import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseFirestore

class LoginViewModel: ObservableObject {
    
    let auth = Auth.auth()
    let db = Firestore.firestore()

    @Published var signedIn = false
    @Published var loginStatus = ""


    
    var isSignedIn: Bool{
        print(auth.currentUser?.uid)
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password){ [weak self] result, error in
            guard result != nil, error == nil else{
                print(error)
                self?.loginStatus = error!.localizedDescription
                return
            }
            // Success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    
    func signUp(email: String, password: String, userName: String){
        auth.createUser(withEmail: email, password: password){[weak self] result, error in
            guard result != nil, error == nil else{
                if let err = error {
                    print("Failed to create user:", err)
                    self?.loginStatus = "Failed to create user:\(err)"
                }
                return
            }
            // Success
            // Create user in firestore
            self?.loginStatus = "Succesfully created user: \(result?.user.uid ?? "")"
            let user = User()
            user.userName = userName
            do {
                try self?.db.collection("users").document((result?.user.uid)!).setData(from:user)
                }
            catch let error{
                print(error)
            }
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

