//
//  ZStackDemoView.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/10.
//

import SwiftUI

struct ZStackDemoView: View {
    var body: some View {
        ZStack {
            Image("niagara-falls")
            Text("Hacking with Swift")
                .font(.largeTitle)
                .background(Color.black)
                .foregroundColor(.white)
        }
        ZStack(alignment: .leading) {
            Image("niagara-falls")
            Text("Hacking with Swift")
                .font(.largeTitle)
                .background(Color.black)
                .foregroundColor(.white)
        }
        ZStack {
            Rectangle()
                .fill(Color.green)
                .frame(width: 50, height: 50)
                .zIndex(3)

            Rectangle()
                .fill(Color.red)
                .frame(width: 100, height: 100)
                .zIndex(2)
        }
    }
}

#Preview {
    ZStackDemoView()
}
