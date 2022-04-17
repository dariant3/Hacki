//
//  SessionPlayView.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-27.
//

import SwiftUI
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import MapKit
import UIKit

struct SessionPlayView: View{
    @StateObject private var vm: SessionPlayViewModel = SessionPlayViewModel()
    @EnvironmentObject private var uvm: UserViewModel
    @EnvironmentObject private var lvm: LocationViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var currentRally: String = ""
    
    @State private var selectedVisibility: Visibility = .invisible
    
    enum Visibility: String, CaseIterable, Identifiable {
        case invisible, visible
        var id: Self { self }
    }
    
    @FocusState private var isEntryFocused: Bool
    
    @State private var duration: TimeInterval = TimeInterval()
    @State private var durationString = ""
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View{
        
        let smallCircleSize : CGFloat = 120
        VStack{
            ZStack{
                TextField("",text:$currentRally)
                    .keyboardType(.numberPad)
                    .background(
                        Circle()
                            .strokeBorder(Color.accentColor,lineWidth: 10)
                            .background(
                                Circle()
                                    .fill(Color.white)
                            )
                            .frame(width: 300, height: 300)
                    )
                    .font(Font.system(size: 80))
                    .foregroundColor(Color.accentColor)
                    .focused($isEntryFocused)
                    .multilineTextAlignment(.center)
                    .onAppear(){
                        self.isEntryFocused = true
                        uvm.fetchUser()
                    }
                    .frame(alignment: .topLeading)
                VStack{
                    VStack{
                        Text(String(vm.session.rallies.max() ?? 0))
                            .font(Font.system(size: 40))
                        Label("Best",systemImage: "star.circle")
                    }
                    .background(
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: smallCircleSize, height: smallCircleSize)
                    )
                    .foregroundColor(Color.white)
                    .frame(width: 330, alignment: .leading)
                    
                    Spacer()
                    Button(action:enterRally){
                        Text("Enter")
                    }
                    .background(
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: smallCircleSize, height: smallCircleSize)
                    )
                    .font(Font.system(size: 40))
                    .foregroundColor(Color.white)
                    .frame(width: 330, alignment: .trailing)
                    
                }
                .frame(width: 300, height: 300) // Vstack
            }
            .frame(width: 300, height: 300)
            .padding()
            
            Label("Visibility",systemImage: "eye")
                .font(Font.headline)
            
            Picker("Visibility", selection: $lvm.locationVis) {
                Text("Visible").tag(true)
                Text("Invisible").tag(false)
                //                ForEach(Visibility.allCases) { vis in
                //                    Text(vis.rawValue.capitalized)
                //                }
            }
            .onChange(of: lvm.locationVis){ vis in
                lvm.toggleVisibility(vis: vis)
            }
            .foregroundColor(Color.accentColor)
            .pickerStyle(.segmented)
            
            HStack{
                VStack{
                    Text("\(String(vm.session.rallyAvg))")
                        .font(Font.headline)
                    Text("Average")
                }
                //            VStack{
                //                Text("\(String(vm.session.rallyAvg))")
                //                    .font(Font.headline)
                //                Text("Calories")
                //            }
                VStack{
                    Text("\(String(durationString))")
                        .onReceive(timer) { input in
                            duration = input.timeIntervalSince(vm.session.startTime)
                            durationString = vm.dcf.string(from: duration) ?? ""
                        }
                        .font(Font.headline)
                    Text("Duration")
                }
            }
            Divider()
            ScrollView(.horizontal){
                HStack(spacing:5){
                    ForEach(vm.session.rallies.reversed(),id:\.self) { value in
                        Text("\(String(value))")
                    }
                }
                .padding()
            }
            Divider()
            Button(action: addSession){
                Text("Finished")
            }
            .foregroundColor(Color.white)
            .frame(width: 200, height: 50)
            .background(Color.accentColor)
            .cornerRadius(15)
            
            Spacer()
                .navigationTitle("Current Session")
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: backButton, trailing: lvm.locationVis ? Eye() :  nil)
        } // Vstack
    }
    
    var backButton : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        lvm.toggleVisibility(vis: false)
        lvm.locationVis = false
    }) {
        HStack {
            Label("",systemImage:"x.circle")
            Text("Cancel")
        }
    }
    }
    func enterRally(){
        guard let entry = Int(currentRally) else { return }
        vm.session.rallies.append(entry)
        currentRally = ""
        isEntryFocused = true
    }
    
    func addSession(){
        vm.addSession()
        vm.updateUserStats(
            user: uvm.user,
            rallyBest: vm.session.rallyBest,
            sessionTotal: vm.session.sessionTotal
        )
        lvm.locationVis = false
        self.presentationMode.wrappedValue.dismiss()
    }
}


//struct SessionPlayView_Previews: PreviewProvider {
//    static var previews: some View {
//        SessionPlayView(isSessionPlayViewShown:true)
//    }
//}
