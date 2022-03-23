//
//  User.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-14.
//
import UIKit
import Foundation
import FirebaseFirestoreSwift

class User:ObservableObject, Identifiable, Codable{
    @DocumentID var id: String? = UUID().uuidString
    var name: String = ""
    var email: String = ""
    
    init(id: String, name: String, email: String){
        self.id = id
        self.name = name
        self.email = email
    }
    
    enum CodingKeys: String, CodingKey{
        case id = "userId"
        case name = "userName"
        case email = "email"
    }
}
