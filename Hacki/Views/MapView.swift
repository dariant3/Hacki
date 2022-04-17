//
//  MapView.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-04-13.
//

import Foundation
import SwiftUI
import MapKit

struct MapView: View {
    
    @EnvironmentObject var vm: LocationViewModel
    @EnvironmentObject var uvm: UserViewModel
    
    var body: some View {
        NavigationView{
            Map(coordinateRegion: $vm.region, showsUserLocation: false, annotationItems: vm.users) { item in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.location!.latitude, longitude: item.location!.longitude)){
                    NavigationLink{
                        HackerDetailsView(user: item)
                    } label: {
                        PlaceAnnotationView(userName: item.userName, color: item.userName == uvm.user?.userName ? .green : .red)
                    }
                    .onAppear{
                        print("Item ID: \(item.id ?? "")")
                    }
                    
                }
            }
            .onAppear{
                print("UVM user id: \(uvm.user?.id ?? "")")
            }
            .navigationBarItems(trailing: vm.locationVis ? Eye() :  nil)
            .navigationTitle("Open Sessions")
            .navigationBarTitleDisplayMode(.inline)
        }
        //.edgesIgnoringSafeArea(.top)
        
        .onAppear(){
            vm.fetchUsers()
            vm.getRegion()
        }
        
        
    }
    struct HackerDetailsView: View {
        let user : User
        
        var body: some View {
            VStack{
                Image("bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .topLeading)
                    .clipped()
                Text(user.userName)
                    .font(.system(size: 56.0))
                    .padding()
                HStack(spacing:20){
                    VStack{
                        Text("\(user.bestRally)")
                            .font(.system(size: 56.0))
                        Label("Best Rally",systemImage: "star.circle")
                    }
                    .frame(width: UIScreen.main.bounds.size.width/2)
                    VStack{
                        Text("\(user.avgRally)")
                            .font(.system(size: 56.0))
                        Label("Average Rally",systemImage: "bolt.horizontal.circle")
                    }
                    .frame(width: UIScreen.main.bounds.size.width/2)
                }
                .padding()
                HStack(spacing:20){
                    VStack{
                        Text("\(user.bestSession)")
                            .font(.system(size: 56.0))
                        Label("Best Session",systemImage: "star.circle")
                    }
                    .frame(width: UIScreen.main.bounds.size.width/2)
                    VStack{
                        Text("\(user.avgSession)")
                            .font(.system(size: 56.0))
                        Label("Average Session",systemImage: "bolt.horizontal.circle")
                    }
                    .frame(width: UIScreen.main.bounds.size.width/2)
                }
                .padding()
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    struct PlaceAnnotationView: View {
        //@State private var showTitle = true
        
        let userName: String
        let color: Color
        
        var body: some View {
            VStack(spacing: 0) {
                Text(userName)
                    .font(.callout)
                    .padding(5)
                    .background(Color(.white))
                    .cornerRadius(10)
                //.opacity(showTitle ? 0 : 1)
                
                Image(systemName: "mappin.circle.fill")
                    .font(.title)
                    .foregroundColor(color)
                
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(color)
                    .offset(x: 0, y: -5)
            }
            //        .onTapGesture {
            //          withAnimation(.easeInOut) {
            //            showTitle.toggle()
            //          }
            //        }
        }
    }
}
