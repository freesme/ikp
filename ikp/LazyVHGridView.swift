//
//  LazyVHGridView.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/11.
//

import SwiftUI

struct LazyVHGridView: View {
    let data = (1...100).map { "Item \($0)" }

    // 用于设置不同背景色的颜色数组
    let colors: [Color] = [.red, .blue, .green, .yellow]

    let columns = [
        // 每个网格的最小大小为 80点
        GridItem(.adaptive(minimum: 80))
    ]
    let columns2 = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    let columns3 = [
        GridItem(.fixed(100)),
        GridItem(.flexible()),
    ]

    let items = 1...50

    let rows = [
        GridItem(.fixed(50)),
        GridItem(.fixed(50)),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(Array(data.enumerated()), id: \.element) {
                    index,
                    item in
                    Text(item)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(colors[index % colors.count].opacity(0.3))
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: 200)

        ScrollView {
            LazyVGrid(columns: columns2, spacing: 20) {
                ForEach(Array(data.enumerated()), id: \.element) {
                    index,
                    item in
                    Text(item)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(colors[index % colors.count].opacity(0.3))
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: 200)

        ScrollView {
            LazyVGrid(columns: columns3, spacing: 20) {
                ForEach(Array(data.enumerated()), id: \.element) {
                    index,
                    item in
                    Text(item)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(colors[index % colors.count].opacity(0.3))
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: 200)

        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, alignment: .center) {
                ForEach(Array(items.enumerated()), id: \.element) {
                    index,
                    item in
                    Image(systemName: "\(item).circle.fill")
                        .font(.title2)
                        .padding(8)
                        .background(colors[index % colors.count].opacity(0.3))
                        .cornerRadius(8)
                }
            }
            .frame(height: 150)
        }
    }
}

#Preview {
    LazyVHGridView()
}
