//
//  StackDemoView.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/10.
//

import SwiftUI

struct StackDemoView: View {
    var body: some View {
        VStack(spacing: 50) {
            Text("swift")
            Text("rocks")
        }

        Divider()

        VStack(alignment: .leading, spacing: 20) {
            Text("Spacer... see")
            Spacer()
            Text("World ...")
            // Spacers 会自动划分所有剩余空间，这意味着如果您使用多个垫片，则可以按不同数量划分空间
            Spacer()
            Spacer()
            Spacer()
            Text("Have")
            Divider()
            Text("Divider")
        }
        
        VStack {
            Text("First Label")
            Spacer()
                .frame(height: 50)
            Text("Second Label")
        }
        
        VStack {
            Text("First Label")
            Spacer(minLength: 50)
            Text("Second Label")
        }

    }
}

#Preview {
    StackDemoView()
}
