//
//  SessionViewModel.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class SessionViewModel: ObservableObject{
    @Published var sessions = [Session]()
    
    @Published var avgSession = 0
    @Published var avgRally = 0
    //private var db = Firestore.firestore()
    let auth = Auth.auth()
    let db = Firestore.firestore()

    let df = DateFormatter()
    let dcf = DateComponentsFormatter()
    
    init(){
        df.dateFormat = "YY/MM/dd"
    }

    func fetchSessions() {
        if let uid = auth.currentUser?.uid {
            db.collection("users").document(uid).collection("sessions").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.sessions = querySnapshot!.documents.compactMap{ (queryDocumentSnapshot) -> Session? in
                        return try? queryDocumentSnapshot.data(as: Session.self)
                    }
                    var rallyAvgs : [Int] = []
                    var sessionTotals : [Int] = []
                    for session in self.sessions {
                        rallyAvgs.append(session.rallyAvg)
                        sessionTotals.append(session.sessionTotal)
                    }
                    self.avgRally = rallyAvgs.reduce(0,+) / rallyAvgs.count
                    self.avgSession = sessionTotals.reduce(0,+) / sessionTotals.count
                }
            }
        }
    }
    
    func updateUserAvgs(user: User?){
        if let id = auth.currentUser?.uid {
            user?.avgRally = avgRally
            user?.avgSession = avgSession
            let docRef = db.collection("users").document(id)
            do {
                try docRef.setData(from: user)
            }
            catch {
                print(error)
            }
        }
    }
    
    
    
}


