//
//  LoginViewModel.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-22.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var credentials = Credentials()
    
    var loginDisabled: Bool{
        credentials.email.isEmpty || credentials.password.isEmpty
    }
    
    
}
