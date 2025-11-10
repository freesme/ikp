//
//  DragGestureView.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/11.
//

import SwiftUI

struct DragGestureView: View {
    @State var dragAmount = CGSize.zero

    var body: some View {
        VStack {
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .white]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 200, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .rotation3DEffect(
                    .degrees(-Double(dragAmount.width) / 20),
                    axis: (x: 0, y: 1, z: 0)
                )
                .rotation3DEffect(
                    .degrees(Double(dragAmount.height / 20)),
                    axis: (x: 1, y: 0, z: 0)
                )
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged { dragAmount = $0.translation }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                dragAmount = .zero
                            }
                        }
                )
        }
        .frame(width: 400, height: 400)
    }
}

#Preview {
    DragGestureView()
}
