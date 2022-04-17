//
//  Eye.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-04-13.
//

import SwiftUI

struct Eye: View {
    var body: some View {
        Label("Visible",systemImage: "eye")
            .foregroundColor(.green)
    }
}

struct Eye_Previews: PreviewProvider {
    static var previews: some View {
        Eye()
    }
}
