//
//  Session.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-24.
//

import Foundation
import FirebaseFirestoreSwift

struct Session: Identifiable, Codable, Hashable {
    @DocumentID var id: String? = UUID().uuidString
    var startTime: Date = Date()
    var endTime: Date? = nil
    var rallies: [Int] = []
    var rallyBest: Int {
        get{
            rallies.max() ?? 0
        }
    }
    var rallyAvg: Int {
        get{
//            let temp = rallies.count != 0 ? Double(rallies.reduce(0,+)) / Double(rallies.count) : 0
//            return round(temp * 10) / 10.0
            if(!rallies.isEmpty){
                return Int(rallies.reduce(0,+) / rallies.count)
            }
            else {
                return 0
            }
        }
    }
    var sessionTotal: Int {
        get{
            rallies.reduce(0,+)
        }
    }
    var duration: TimeInterval? {
        get{
            endTime?.timeIntervalSince(startTime)
        }
    }
}
