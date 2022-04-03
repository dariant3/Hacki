//
//  SessionView.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-14.
//

import SwiftUI
import FirebaseAuth


struct SessionView: View {
    
    //let auth = Auth.auth()
    var body: some View {
        NavigationView{
            NavigationLink(destination: SessionPlayView()){
                Label("Start Session",systemImage: "arrowtriangle.right.circle.fill")
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50)
                    .background(Color.accentColor)
                    .cornerRadius(15)
            }
            .navigationTitle("Sessions")
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(StackNavigationViewStyle())

//            List(viewModel.sessions) {session in
//
//
//            }
//            .onAppear(){
//                self.viewModel.fetchData()
//            }
        }
    }
}



struct ListRow: View {
    //var eachSession: Session
    var body: some View{
//        HStack{
//            Text(eachSession.time)
//        }
        Text("")
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
    }
}
