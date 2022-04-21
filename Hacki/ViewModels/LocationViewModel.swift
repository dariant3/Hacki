//
//  LocationViewModel.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-04-12.
//


import CoreLocation
import MapKit
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import UIKit



class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus
//    @Published var lastSeenLocation: CLLocation?
    @Published var locationVis: Bool = false
    @Published var location: GeoPoint?
    @Published var currentPlacemark: CLPlacemark?
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    @Published var users = [User]()

    private var db = Firestore.firestore()
    private var auth = Auth.auth()

    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 0.4
        locationManager.startUpdatingLocation()
    }
    
    
    
    func fetchUsers() {
        db.collection("users").addSnapshotListener{ (querySnapshot,error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            let temp = documents.compactMap{ (queryDocumentSnapshot) -> User? in
                return try? queryDocumentSnapshot.data(as: User.self)
            }
            self.users = temp.filter { $0.location != nil && $0.locationVis == true}
        }
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func getRegion() {
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0, longitude: locationManager.location?.coordinate.longitude ?? 0), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    }
    
    func toggleVisibility(vis: Bool){
        if let id = auth.currentUser?.uid {
            let docRef = db.collection("users").document(id)
            docRef.updateData([
                "locationVis": vis,
                "location": GeoPoint(
                    latitude: locationManager.location?.coordinate.latitude ?? 0,
                    longitude: locationManager.location?.coordinate.longitude ?? 0
                )
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        }
        //self.locationVis = vis
    }

}
