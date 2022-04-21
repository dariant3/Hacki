//
//  MapView.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-04-13.
//

import Foundation
import SwiftUI
import MapKit
import SDWebImageSwiftUI

struct MapView: View {
    
    @EnvironmentObject var vm: LocationViewModel
    @EnvironmentObject var uvm: UserViewModel
    
    var body: some View {
        NavigationView{
            Map(coordinateRegion: $vm.region, showsUserLocation: false, annotationItems: vm.users) { user in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: user.location!.latitude, longitude: user.location!.longitude)){
                    NavigationLink{
                        HackerDetailsView(user: user)
                    } label: {
                        PlaceAnnotationView(user: user, color: user.userName == uvm.user?.userName ? .green : Color(hex:"E6562A"))
                    }
                    .onAppear{
                        print("Item ID: \(user.id ?? "")")
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
                ZStack{
                    Image("bg")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .topLeading)
                        .clipped()
                        .task{
                            //uvm.fetchProfileURL(id:user.id)
                            
                        }
                    VStack{
                        if let profileUrl = user.profileURL {
                            WebImage(url: URL(string: profileUrl))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .cornerRadius(75)
                        } else {
                            Image(systemName: "person.fill")
                                .font(.system(size:75))
                                .foregroundColor(.white)
                        }
                    }
                    .overlay(RoundedRectangle(cornerRadius:75)
                                .stroke(Color.white, lineWidth: 4)
                    )
                } // zstack
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
        let user: User
        let color: Color
        
        var body: some View {
            VStack(spacing: 3) {
                Text(user.userName)
                    .font(.callout)
                    .padding(5)
                    .background(Color(.white))
                    .cornerRadius(10)
                    .foregroundColor(color)
                if let profileUrl = user.profileURL {
                    WebImage(url: URL(string: profileUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 26, height: 26)
                        .cornerRadius(13)
                } else {
                    Image(systemName: "person.circle")
                        .font(.system(size:20))
                        .foregroundColor(color)
                }
//                Image(systemName: "mappin.circle.fill")
//                    .font(.title)
//                    .foregroundColor(color)
                
                
            }
            //        .onTapGesture {
            //          withAnimation(.easeInOut) {
            //            showTitle.toggle()
            //          }
            //        }
        }
    }
}
