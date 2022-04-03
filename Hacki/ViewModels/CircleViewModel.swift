//
//  CircleViewModel.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-16.
//

import Foundation
import FirebaseFirestore


class CircleViewModel: ObservableObject{
    
    @Published var circle: HackCircle = HackCircle(name: "")

    private var db = Firestore.firestore()

    func addCircle(circle: HackCircle){
        do{
            let _ = try db.collection("circles").addDocument(from:circle)
        }
        catch{
            print(error)
        }
    }
}

