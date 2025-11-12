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
    @State private var amount: CGFloat = 50
    @State private var name = "Paul"

    // 文本格式
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()

    let dueDate = Date()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Picker("TExt alignment", selection: $alignment) {
                    ForEach(alignments, id: \.self) { alignment in
                        Text(String(describing: alignment))
                    }
                }
                Text("这是一段文本，长文本展示TextAlignment文本对齐方式产生的效果")
                    .font(.largeTitle)
                    .multilineTextAlignment(alignment)
                    .frame(width: 300)
                Text(
                    "日期文本格式 Task due date: \(dueDate, formatter: Self.taskDateFormat)"
                )

                Text("Hello World")
                    .tracking(20)
                Text("ffi")
                    .font(.custom("AmericanTypewriter", size: 36))
                    .kerning(amount)
                Text("ffi")
                    .font(.custom("AmericanTypewriter", size: 36))
                    .tracking(amount)

                Slider(value: $amount, in: 0...100) {
                    Text("Adjust the amount of spacing")
                }
                TextField("Shout your name at me", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textCase(.uppercase)
                    .padding(.horizontal)
                Label("Your account", systemImage: "person.crop.circle")
                    .font(.title)

                VStack(alignment: .leading) {
                    Label("Text Only", systemImage: "heart")
                        .font(.title)
                        .labelStyle(TitleOnlyLabelStyle())

                    Label("Icon Only", systemImage: "star")
                        .font(.title)
                        .labelStyle(IconOnlyLabelStyle())

                    Label("Both", systemImage: "paperplane")
                        .font(.title)
                        // default
                        .labelStyle(TitleAndIconLabelStyle())

                    Label {
                        Text("Paul Hudson")
                            .foregroundColor(.primary)
                            .font(.title3)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Capsule())
                    } icon: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                            .frame(width: 32, height: 64)
                    }
                }
                
                VStack(alignment: .leading) {
                    // md语法支持
                    Text("This is regular text.")
                    Text(
                        "* This is **bold** text, this is *italic* text, and this is ***bold, italic*** text."
                    )
                    Text("~~A strikethrough example~~")
                    Text("`Monospaced works too`")
                    Text("Visit Apple: [click here](https://apple.com)")
                }
                .textSelection(.enabled)
            }
            .padding()
        }
        .navigationTitle("文本对齐")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        TextAlignmentView()
    }
}
