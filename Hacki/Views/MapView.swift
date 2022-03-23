//
//  MapView.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-14.
//

import SwiftUI

struct MapView: View {
    
    @ObservedObject private var viewModel = CirclesViewModel()
    
    var body: some View {
        NavigationView{
            List(viewModel.circles) {circle in
                VStack(alignment: .leading){
                    Text(circle.name)
                    Text("Hi again")
                }
                
            }
            .onAppear(){
                self.viewModel.fetchData()
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
