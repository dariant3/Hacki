//
//  SessionView.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-14.
//

import SwiftUI
import FirebaseAuth
import Foundation

struct SessionView: View {
    @EnvironmentObject var vm: SessionViewModel
    @EnvironmentObject var uvm: UserViewModel
    @EnvironmentObject var lvm: LocationViewModel
    
//    @State private var userName = ""
//    @State private var isSessionPlayViewShown = false
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: SessionPlayView()){
                    Label("Start Session",systemImage: "arrowtriangle.right.circle.fill")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(Color.accentColor)
                        .cornerRadius(15)
                }
                .onAppear(){
                    vm.fetchSessions()
                }
                .onDisappear(){
                    vm.updateUserAvgs(user: uvm.user)
                }
                .navigationTitle("Sessions")
                .navigationBarTitleDisplayMode(.inline)
                .navigationViewStyle(StackNavigationViewStyle())

                List{
                    Section(header: HStack(){
                        Text("Date")
                        Spacer()
                        Text("Avg")
                            .frame(width: 40)
                        Text("Best")
                            .frame(width: 40)
                        Text("Duration")
                            .frame(width: 80)
                    }){
                        ForEach(vm.sessions.sorted{$0.rallyAvg > $1.rallyAvg}){ s in
                            ListRow(session: s)
                        }
                    }
                }
                .listStyle(.plain)
            }//Vstack
            .navigationBarItems(trailing: lvm.locationVis ? Eye() :  nil)
        }//navigationview
    }//view
}//sessionview

struct ListRow: View {
    @EnvironmentObject var vm: SessionViewModel
    var session: Session
    
    var body: some View{
        HStack{
            Text("\(vm.df.string(from: session.endTime!))")
            Spacer()
            Text("\(session.rallyAvg)")
                .frame(width: 40)
            Text("\(session.rallyBest)")
                .frame(width: 40)
            Text("\(vm.dcf.string(from:session.duration!) ?? "")")
                .frame(width: 80)
        }
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
    }
}
