//
//  Auth.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-22.
//

import Foundation
import FirebaseAuth


class AuthService{
    static let shared = AuthService()
    enum APIError: Error{
        case error
    }
    public func signIn(email: String, password: String){
        
        Auth.auth().signIn(withEmail: email, password: password){result, error in
            guard result != nil, error == nil else{
                return
            }
            // Success
            return
        }
    }
}

