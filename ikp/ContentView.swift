//
//  ContentView.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/4.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text("Hello, wordl!")
            HStack {
                Image(systemName: "person")
                    .imageScale(.medium)
                    .formStyle(.grouped)
                Text("WelCome")
                Image(systemName: "globe")
                    .imageScale(.small)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
