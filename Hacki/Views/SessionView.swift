//
//  SessionView.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-14.
//

import SwiftUI
import FirebaseAuth

struct SessionView: View {
    let auth = Auth.auth()
    var body: some View {
        Text(auth.currentUser!.uid)
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
    }
}
