//
//  CirclesViewModel.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-15.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class CirclesViewModel:ObservableObject{
    @Published var circles = [Circle]()
    
    private var db = Firestore.firestore()
    

    
    func fetchData() {
        db.collection("circles").addSnapshotListener{ (querySnapshot,error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.circles = documents.compactMap{ (queryDocumentSnapshot) -> Circle? in
                return try? queryDocumentSnapshot.data(as: Circle.self)
            }
            
        }
    }
}
