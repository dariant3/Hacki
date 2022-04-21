//
//  ProfileView.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-14.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    @EnvironmentObject var uvm : UserViewModel
    
    @State var shouldShowImagePicker = false
    //@State var profilePic: UIImage?
    
    var body: some View {
        VStack(){
            ZStack{
                Image("bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.size.width, height: 200, alignment: .topLeading)
                    .clipped()
                    .task{
                        uvm.fetchUser()
                        //uvm.fetchProfileURL(id:nil)
                    }

                Button{
                    shouldShowImagePicker
                        .toggle()
                } label: {
                    VStack{
                        if let profileUrl = uvm.user?.profileURL {
                            WebImage(url: URL(string: profileUrl))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .cornerRadius(75)
                        } else {
                            Image(systemName: "person.circle")
                                .font(.system(size:100))
                                .foregroundColor(.white)
                        }
                    }
                    .overlay(RoundedRectangle(cornerRadius:75)
                                .stroke(Color.white, lineWidth: 4)
                    )
                } // label
            } // zstack
            Text(uvm.user?.userName ?? "")
                .font(.system(size: 56.0))
                .padding()
            VStack{
                HStack(spacing:20){
                    VStack{
                        Text("\(uvm.user?.bestRally ?? 0)")
                            .font(.system(size: 56.0))
                        Label("Best Rally",systemImage: "star.circle")
                    }
                    .frame(width: UIScreen.main.bounds.size.width/2)
                    VStack{
                        Text("\(uvm.user?.avgRally ?? 0)")
                            .font(.system(size: 56.0))
                        Label("Average Rally",systemImage: "bolt.horizontal.circle")
                    }
                    .frame(width: UIScreen.main.bounds.size.width/2)
                }
                .padding()
                HStack(spacing:20){
                    VStack{
                        Text("\(uvm.user?.bestSession ?? 0)")
                            .font(.system(size: 56.0))
                        Label("Best Session",systemImage: "star.circle")
                    }
                    .frame(width: UIScreen.main.bounds.size.width/2)
                    VStack{
                        Text("\(uvm.user?.avgSession ?? 0)")
                            .font(.system(size: 56.0))
                        Label("Average Session",systemImage: "bolt.horizontal.circle")
                    }
                    .frame(width: UIScreen.main.bounds.size.width/2)
                }
                .padding()
            }
            
            Spacer()
        } // Vstack
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: {
            uvm.uploadImage(image: uvm.profilePic!)
        }){
            ImagePicker(image: $uvm.profilePic)
        }
        
    }//body
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
