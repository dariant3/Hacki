//
//  MainView.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-14.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: appViewModel
    @State var showMenu = false
    
    //let user: User
    var body: some View {
        
        GeometryReader{ geometry in
            ZStack(alignment: .leading){
                TabView {
                    ProfileView()
                        .tabItem{
                            Label("Profile",systemImage: "person.circle")
                        }
                    SessionView()
                        .tabItem{
                            Label("Session",systemImage: "arrowtriangle.right.circle")
                        }
                    MapView()
                        .tabItem{
                            Label("Community",systemImage: "globe.americas.fill")
                        }
                    MenuView()
                        .tabItem{
                            Label("Menu",systemImage:"line.3.horizontal.circle")
                        }
                    
                }
                
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
