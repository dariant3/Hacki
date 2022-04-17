//
//  User.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-14.
//
import UIKit
import Foundation
import FirebaseFirestoreSwift
import MapKit
import FirebaseFirestore
import FirebaseAuth


class User: ObservableObject, Identifiable, Codable{
   
    @DocumentID var id: String? = UUID().uuidString
    var userName: String = ""
    var bestRally: Int = 0
    var bestSession: Int = 0
    var avgRally: Int = 0
    var avgSession: Int = 0
    var location: GeoPoint? = nil
    var locationVis: Bool? = false
    
    enum CodingKeys: String, CodingKey{
        case userName = "userName"
        case bestRally = "bestRally"
        case bestSession = "bestSession"
        case avgRally = "avgRally"
        case avgSession = "avgSession"
        case location = "location"
        case locationVis = "locationVis"
    }
}
