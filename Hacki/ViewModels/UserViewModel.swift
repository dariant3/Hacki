//
//  File.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-16.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import UIKit


class UserViewModel: ObservableObject{
    
    @Published var user: User?
    @Published var profilePic: UIImage?
    
    let auth = Auth.auth()
    private var db = Firestore.firestore()
    private var storageManager = StorageManager()

    
    public func fetchUser() {
        guard auth.currentUser != nil else{
            return
        }
        let docRef = db.collection("users").document("\(auth.currentUser!.uid)")
        
        docRef.getDocument(as: User.self) { result in
            switch result {
            case .success(let user):
                self.user = user

            case .failure(let error):
                print("Error decoding document: \(error.localizedDescription)")
            }
        }
        

    }
    
    func changeUserImage(image: UIImage){
        storageManager.uploadImage(image: image)
    }
    
//    func fetchUserImage() -> UIImage?{
//        storageManager.fetchProfilePic()
//    }
//    func updateUser(user: User){
//        if let id = user.id {
//            let docRef = db.collection("users").document(id)
//            do {
//                try docRef.setData(from: user)
//            }
//            catch {
//                print(error)
//            }
//        }
//    }
}
