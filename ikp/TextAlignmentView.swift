//
//  TextAlignmentView.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/9.
//

import SwiftUI

struct TextAlignmentView: View {
    let alignments: [TextAlignment] = [.leading, .trailing, .center]
    @State private var alignment = TextAlignment.leading

    var body: some View {
        VStack {
            Picker("TExt alignment", selection: $alignment) {
                ForEach(alignments, id: \.self) { alignment in
                    Text(String(describing: alignment))
                }
            }
            Text("这是一段文本，长文本展示TextAlignment文本对齐方式产生的效果")
                .font(.largeTitle)
                .multilineTextAlignment(alignment)
                .frame(width: 300)
        }
    }
}

#Preview {
    TextAlignmentView()
}
