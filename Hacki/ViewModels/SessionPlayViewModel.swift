//
//  SessionPlayViewModel.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-27.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import UIKit
import MapKit

class SessionPlayViewModel: ObservableObject {
    var session = Session()
    
    let auth = Auth.auth()
    let db = Firestore.firestore()
    
    let dcf = DateComponentsFormatter()
    
    func addSession(){
        guard let currentUser = auth.currentUser else  {
            return
        }
        guard session.id != nil else{
            return
        }
        guard !session.rallies.isEmpty else{
            return
        }
        db.collection("users").document(currentUser.uid).collection("sessions").document(session.id!).setData([
            "rallies": session.rallies,
            "startTime": Timestamp(date:session.startTime),
            "endTime": Timestamp(date:Date())
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func updateUserStats(user: User?, rallyBest: Int, sessionTotal: Int){
        if let id = auth.currentUser?.uid {
            if(rallyBest > (user?.bestRally)!){
                user?.bestRally = rallyBest
            }
            if(sessionTotal > (user?.bestSession)!){
                user?.bestSession = sessionTotal
            }
            let docRef = db.collection("users").document(id)
            do {
                try docRef.setData(from: user)
            }
            catch {
                print(error)
            }
        }
    }
    
//    func toggleVisibility(vis: String){
//        if let id = auth.currentUser?.uid {
//            let docRef = db.collection("users").document(id)
//            docRef.updateData([
//                "locationVis": vis == "visible",
//                "location": GeoPoint(
//                    latitude: 0,
//                    longitude: 0
//                )
//            ]) { err in
//                if let err = err {
//                    print("Error updating document: \(err)")
//                } else {
//                    print("Document successfully updated")
//                }
//            }
//        }
//    }

}
