//
//  File.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-16.
//

import Foundation
import FirebaseFirestore


class UserViewModel: ObservableObject{
    
    @Published var user: User?

    private var db = Firestore.firestore()

    func addUser(user: User){
        do{
            let _ = try db.collection("users").addDocument(from:user)
        }
        catch{
            print(error)
        }
    }
    
//    func getUser(uid:String)
//    {
//        let docRef = db.collection("users").document(uid)
//
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document data: \(dataDescription)")
//            } else {
//                print("Document does not exist")
//            }
//        }
//    }
    
//    func fetchData() {
//        db.document(<#T##documentPath: String##String#>)
//        db.collection("circles").addSnapshotListener{ (querySnapshot,error) in
//            guard let documents = querySnapshot?.documents else {
//                print("No documents")
//                return
//            }
//            self.circles = documents.compactMap{ (queryDocumentSnapshot) -> Circle? in
//                return try? queryDocumentSnapshot.data(as: Circle.self)
//            }
//
//        }
//    }
}
