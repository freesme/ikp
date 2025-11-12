//
//  TextExamplesView.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/4.
//

import SwiftUI

struct TextExamplesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Hello World")
                    .padding()
                
                Text("HelloWorld-1")
                
                let context = """
                    This is some longer text that is limited to three lines maximum, so anything more than that will cause the text to clip.
                    """
                Text(context)
                    .lineLimit(3)
                    .frame(width: 300)
                    .padding()
                    .lineSpacing(20)  // 调整行距
                
                Text(
                    "This is an extremely long string of text that will never fit even the widest of iOS devices even if the user has their Dynamic Type setting as small as is possible, so in theory it should definitely demonstrate truncationMode()."
                )
                .lineLimit(1)
                //默认是从末尾删除文本并在其中显示省略号，但是您也可以根据字符串各部分重要性将省略号放在中间或开头。
                .truncationMode(.middle)
                // 字体大小
                .font(.largeTitle)
                // 颜色
                .foregroundColor(Color.red)
                .background(Color.gray)
                .foregroundColor(Color(.white))
                
                Text("The best laid plans")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .font(.headline)
                
                // 文本对齐方式 multilineTextAlignment
                Text(
                    "This is an extremely long text string that will never fit even the widest of phones without wrapping"
                )
                .font(.largeTitle)
                .multilineTextAlignment(.leading)
                .frame(width: 300)
            }
            .padding()
        }
        .navigationTitle("文本示例")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        TextExamplesView()
    }
}

