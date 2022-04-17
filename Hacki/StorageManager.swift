//
//  FirebaseManager.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-04-10.
//

import Foundation
import Firebase
import SwiftUI

class StorageManager: ObservableObject {
    let storage = Storage.storage()
    let auth = Auth.auth()
    
    func uploadImage(image: UIImage){
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
                    }
                }
            }
        }
        
    }
    
    func fetchProfilePic() -> UIImage?{
        var image: UIImage?

        if let id = auth.currentUser?.uid {
            let storageRef = storage.reference().child(id + "/profilePicture/pic.jpg")
            
            storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print("Fetch image error:")
                    print(error)
                } else {
                    // Data for "images/island.jpg" is returned
                    image = UIImage(data: data!) ?? nil
                    if image != nil{
                        print("I worked")
                    }
                }
            }
            
        }
        return image
    }
    
    func deleteItem(item: StorageReference) {
        item.delete { error in
            if let error = error {
                print("Error deleting item", error)
            }
        }
    }
}

extension UIImage {
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
