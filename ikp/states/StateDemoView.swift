//
//  StateDemoView.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/13.
//

import SwiftUI

struct StateDemoView: View {

    @State private var showDeatils = false
    @State private var name: String = "input"

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // 标题
                Text("简单的状态控制")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)

                // 状态切换示例
                VStack(alignment: .leading, spacing: 12) {
                    Text("状态切换示例")
                        .font(.headline)
                        .foregroundColor(.secondary)

                    Button("show details") {
                        showDeatils.toggle()
                        print("click btn")
                    }
                    .frame(height: 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)

                    if showDeatils {
                        Text("my Email: x@moon1it.com")
                            .font(.largeTitle)
                            .padding(.horizontal)
                            .transition(.opacity)
                    }
                }
                .padding()
                .background(Color.blue.opacity(0.05))
                .cornerRadius(12)

                // ContentShape 示例
                VStack(alignment: .leading, spacing: 12) {
                    Text("ContentShape 示例")
                        .font(.headline)
                        .foregroundColor(.secondary)

                    Text("点击蓝色区域任意位置都可以触发按钮")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Button {
                        print("Button pressed")
                    } label: {
                        Text("Press Me")
                            .padding(20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.blue.opacity(0.3))
                    }
                    // 在 SwiftUI 里，视图默认只在自身可见的内容上响应点击；如果内容是文本，命中区域往往只围绕文字本身。通过设定 Rectangle() 作为内容形状，SwiftUI 会把按钮的可点击范围扩展为它布局占据的整个矩形区域（包含 padding 之后的空间），即使其中有透明或空白部分，也能触发点击。这样可以提升交互体验，避免用户点到文字周围的空白却无法触发按钮
                    .contentShape(Rectangle())
                }
                .padding()
                .background(Color.green.opacity(0.05))
                .cornerRadius(12)

                // 图标按钮示例
                VStack(alignment: .leading, spacing: 12) {
                    Text("禁用 Button 和 NavigationLink 中的图像的覆盖颜色")
                        .font(.headline)
                        .foregroundColor(.secondary)

                    HStack(spacing: 20) {
                        Button {
                            // 执行操作
                        } label: {
                            Image(systemName: "star.fill")
                                .renderingMode(.original)  // 保持原始颜色，不受系统强调色影响
                                .padding(20)
                                .background(Color.yellow.opacity(0.2))
                                .cornerRadius(8)
                        }

                        Button {
                            // 执行操作
                        } label: {
                            Image(systemName: "star.fill")
                                .padding(20)
                                .background(Color.orange.opacity(0.2))
                                .cornerRadius(8)
                        }
                        .buttonStyle(PlainButtonStyle())  // 禁用默认按钮样式
                    }
                }
                .padding()
                .background(Color.purple.opacity(0.05))
                .cornerRadius(12)

                // 文本输入示例
                VStack(alignment: .leading, spacing: 12) {
                    Text("文本输入示例")
                        .font(.headline)
                        .foregroundColor(.secondary)

                    TextField("Enter your name", text: $name)
                        .textFieldStyle(.roundedBorder)

                    Text("Hello,\(name)!")
                    Text(verbatim: "Hello, \(name)!")
                        .font(.title3)
                        .foregroundColor(.primary)
                        .padding(.top, 5)
                }
                .padding()
                .background(Color.pink.opacity(0.05))
                .cornerRadius(12)
            }
            .padding()
        }
    }
}

#Preview {
    StateDemoView()
}
