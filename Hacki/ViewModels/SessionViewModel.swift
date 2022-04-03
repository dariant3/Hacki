//
//  SessionViewModel.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class SessionViewModel: ObservableObject{
    @Published var sessions = [Session]()

    private var db = Firestore.firestore()

    func fetchData() {
        db.collection("sessions").addSnapshotListener{ (querySnapshot,error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.sessions = documents.compactMap{ (queryDocumentSnapshot) -> Session? in
                return try? queryDocumentSnapshot.data(as: Session.self)
            }
        }
    }
}


