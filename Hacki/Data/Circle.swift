//
//  Circle.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-15.
//

import Foundation
import UIKit
import FirebaseFirestoreSwift

class Circle:ObservableObject, Identifiable, Codable{
    @DocumentID var id: String? = UUID().uuidString
    var name: String
    
    init(name: String){
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey{
        case name
    }
}
