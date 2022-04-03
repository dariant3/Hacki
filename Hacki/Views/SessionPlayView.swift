//
//  SessionPlayView.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-27.
//

import SwiftUI

struct SessionPlayView: View{
    @ObservedObject private var vm: SessionPlayViewModel = SessionPlayViewModel()

    @State var currentRally: String = ""

    @State private var selectedVisibility: Visibility = .invisible

    enum Visibility: String, CaseIterable, Identifiable {
        case invisible, friends, visible
        var id: Self { self }
    }

    @FocusState private var isEntryFocused: Bool
    
    
//    @State private var duration = 0
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View{
        
        let smallCircleSize : CGFloat = 120
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
                .font(Font.system(size: 90))
                .foregroundColor(Color.accentColor)
                .focused($isEntryFocused)
                .multilineTextAlignment(.center)
                .onAppear(){
                    self.isEntryFocused = true
                }
                .frame(alignment: .topLeading)
            VStack{
                VStack{
                    Text(String(vm.session.rallies.max() ?? 0))
                    Text("Best")
                }
                    .background(
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: smallCircleSize, height: smallCircleSize)
                    )
                    .font(Font.system(size: 40))
                    .foregroundColor(Color.white)
                    .frame(width: 300, height: smallCircleSize, alignment: .leading)


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
                    .frame(width: 300, height: smallCircleSize, alignment: .trailing)

            }
            .frame(width: 300, height: 400) // Vstack
        }
//        .onReceive(timer){ time in
//            duration += 1
//        }
        // Zstack containing three circles
        Label("Visibility",systemImage: "eye")
            .font(Font.headline)
        Picker("Visibility", selection: $selectedVisibility) {
            ForEach(Visibility.allCases) { vis in
                Text(vis.rawValue.capitalized)
            }
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
//            VStack{
//                Text("\(String(duration))")
//                    .font(Font.headline)
//                Text("Duration")
//            }
        }
        Divider()
        ScrollView(.horizontal){
            HStack{
                ForEach(vm.session.rallies.sorted().reversed(),id:\.self) { value in
                    Text("\(String(value))")
                }
            }

        }
        Divider()
        Spacer()
            .navigationTitle("Current Session")
    }
    func enterRally(){
        guard let entry = Int(currentRally) else { return }
        vm.session.rallies.append(entry)
        currentRally = ""
        isEntryFocused = true
    }
}


struct SessionPlayView_Previews: PreviewProvider {
    static var previews: some View {
        SessionPlayView()
    }
}
