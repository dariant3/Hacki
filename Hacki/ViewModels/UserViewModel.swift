//
//  File.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-16.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import UIKit


class UserViewModel: ObservableObject{
    
    @Published var user: User?
    @Published var profilePic: UIImage?
    //@Published var profileUrl: URL?
    
    let auth = Auth.auth()
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
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
        //profileUrl = await storageManager.fetchProfileURL()
        //fetchProfileURL()
    }
    
    public func uploadImage(image: UIImage){
        if let id = auth.currentUser?.uid {
            let resizedImage = image.aspectFittedToHeight(200)
            let data = resizedImage.jpegData(compressionQuality: 0.2)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            let storageRef = storage.reference().child(id + "/profilePicture/pic.jpg")
            
            if let data = data {
                storageRef.putData(data, metadata: metadata) { (metadata, error) in
                    if let error = error {
                        print("Error while uploading file: ", error)
                    }
                    
                    if let metadata = metadata {
                        print("Metadata: ", metadata)
                        storageRef.downloadURL{ (url, error) in
                            if error != nil {
                                print((error?.localizedDescription)!)
                                //self.profileUrl = nil
                                return
                            }
                            self.updateUserProfileURL(downloadURL: url!)
                        }
                    }
                }
            }
        }
    }
    func updateUserProfileURL(downloadURL: URL){
        if let id = auth.currentUser?.uid {
            let docRef = db.collection("users").document(id)
            docRef.updateData([
                "profileURL": downloadURL.absoluteString
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        }
        fetchUser()
    }
    
    //    func changeUserImage (image: UIImage){
    //        //storageManager.uploadImage(image: image)
    //        uploadImage(image: image)
    ////        profileUrl = await storageManager.fetchProfileURL()
    //    }
    
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
