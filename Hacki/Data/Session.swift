//
//  Session.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-24.
//

import Foundation
import FirebaseFirestoreSwift

struct Session: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var startTime: Date = Date()
    var endTime: Date? = nil
    var rallies: [Int] = []
    var rallyAvg: Double {
        get{
            let temp = rallies.count != 0 ? Double(rallies.reduce(0,+)) / Double(rallies.count) : 0
            return round(temp * 10) / 10.0
        }
    }
}
