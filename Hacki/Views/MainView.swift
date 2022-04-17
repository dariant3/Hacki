//
//  MainView.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-14.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var vm: LocationViewModel
    var body: some View {
        
        TabView {
            ProfileView()
                .tabItem{
                    Label("Profile",systemImage: "person.circle")
                }
            SessionView()
                .tabItem{
                    Label("Sessions",systemImage: "arrowtriangle.right.circle")
                }
            switch vm.authorizationStatus {
            case .notDetermined:
                RequestLocationView()
                    .tabItem{
                        Label("Map",systemImage: "globe.americas.fill")
                    }
            case .restricted:
                ErrorView(errorText: "Location use is restricted.")
                    .tabItem{
                        Label("Map",systemImage: "globe.americas.fill")
                    }
            case .denied:
                ErrorView(errorText: "The app does not have location permissions. Please enable them in settings.")
                    .tabItem{
                        Label("Map",systemImage: "globe.americas.fill")
                    }
            case .authorizedAlways, .authorizedWhenInUse:
                MapView()
                    .tabItem{
                        Label("Map",systemImage: "globe.americas.fill")
                    }
            default:
                Text("Unexpected status")
            }
//            MapInitialView()
//                .tabItem{
//                    Label("Map",systemImage: "globe.americas.fill")
//                }
            MenuView()
                .tabItem{
                    Label("Menu",systemImage:"line.3.horizontal.circle")
                }
        }
        
    }
}


//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//            .environmentObject()
//    }
//}
