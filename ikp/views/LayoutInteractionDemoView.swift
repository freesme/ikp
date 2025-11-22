//
//  LayoutInteractionDemoView.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/23.
//

import SwiftUI

struct LayoutInteractionDemoView: View {
    // 视图 A, B, C 的状态
    @State private var lengthA: Double = 2
    @State private var lengthB: Double = 2
    @State private var lengthC: Double = 2
    
    @State private var priorityA: Double = 0
    @State private var priorityB: Double = 0
    @State private var priorityC: Double = 0
    
    @State private var containerWidth: CGFloat = 350
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                Text("多元素布局交互")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                // 演示区域
                VStack(alignment: .leading) {
                    HStack {
                        Text("总宽度限制")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(Int(containerWidth))")
                            .font(.caption)
                            .monospacedDigit()
                    }
                    
                    // 容器宽度控制
                    Slider(value: $containerWidth, in: 150...380)
                        .accentColor(.gray)
                        .padding(.bottom, 10)
                    
                    // 核心演示容器
                    ZStack(alignment: .top) {
                        // 参考线
                        Rectangle()
                            .fill(Color.gray.opacity(0.1))
                            .frame(width: containerWidth, height: 120)
                            .overlay(
                                Rectangle()
                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                    .foregroundColor(.gray.opacity(0.5))
                            )
                        
                        HStack(spacing: 8) {
                            // 视图 A
                            FlexibleView(
                                name: "A",
                                color: .blue,
                                length: lengthA,
                                priority: priorityA
                            )
                            .layoutPriority(priorityA)
                            
                            // 视图 B
                            FlexibleView(
                                name: "B",
                                color: .green,
                                length: lengthB,
                                priority: priorityB
                            )
                            .layoutPriority(priorityB)
                            
                            // 视图 C
                            FlexibleView(
                                name: "C",
                                color: .orange,
                                length: lengthC,
                                priority: priorityC
                            )
                            .layoutPriority(priorityC)
                        }
                        .frame(width: containerWidth) // 强制限制宽度
                        // .frame(height: 120) 不要限制高度，让它自然撑开
                        .clipped() // 裁剪超出部分（如果有）
                    }
                    .frame(maxWidth: .infinity) // 让 ZStack 本身居中
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.05), radius: 5)
                .padding(.horizontal)
                
                // 控制面板
                VStack(spacing: 20) {
                    ControlRow(
                        name: "视图 A",
                        color: .blue,
                        length: $lengthA,
                        priority: $priorityA
                    )
                    
                    Divider()
                    
                    ControlRow(
                        name: "视图 B",
                        color: .green,
                        length: $lengthB,
                        priority: $priorityB
                    )
                    
                    Divider()
                    
                    ControlRow(
                        name: "视图 C",
                        color: .orange,
                        length: $lengthC,
                        priority: $priorityC
                    )
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.05), radius: 5)
                .padding(.horizontal)
                
                // 说明文案
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "lightbulb.fill")
                            .foregroundColor(.yellow)
                        Text("观察指南")
                            .font(.headline)
                    }
                    .padding(.bottom, 5)
                    
                    Group {
                        Text("• **默认行为**：当总内容超过容器宽度时，SwiftUI 会压缩所有视图，直到它们达到最小尺寸，然后截断文本。")
                        Text("• **优先级 (.layoutPriority)**：优先级高的视图会先获得所需的全部空间。")
                        Text("• **实验**：把容器宽度调小，让A、B、C都显示不下。然后把 A 的优先级设为 1。你会看到 A 撑开显示完全，而 B 和 C 被严重压缩。")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .background(Color.blue.opacity(0.05))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}

// 可变长度的子视图
struct FlexibleView: View {
    let name: String
    let color: Color
    let length: Double
    let priority: Double
    
    // 根据 length 生成重复字符串，模拟不同长度的内容
    var content: String {
        if length <= 1 { return name }
        return name + String(repeating: "_\(name)", count: Int(length))
    }
    
    var body: some View {
        VStack(spacing: 4) {
            Text(content)
                .font(.system(.body, design: .monospaced))
                .lineLimit(1) // 强制单行，触发空间竞争
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(color.opacity(0.15))
                .foregroundColor(color)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(color, lineWidth: 1.5)
                )
            
            if priority > 0 {
                HStack(spacing: 2) {
                    Image(systemName: "crown.fill")
                        .font(.caption2)
                    Text("P:\(Int(priority))")
                        .font(.caption2)
                }
                .foregroundColor(color)
            }
        }
    }
}

// 单行控制组件
struct ControlRow: View {
    let name: String
    let color: Color
    @Binding var length: Double
    @Binding var priority: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Circle()
                    .fill(color)
                    .frame(width: 8, height: 8)
                Text(name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
            }
            
            HStack {
                Text("长度")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(width: 40, alignment: .leading)
                Slider(value: $length, in: 1...10)
                    .accentColor(color)
            }
            
            HStack {
                Text("权重")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(width: 40, alignment: .leading)
                Slider(value: $priority, in: 0...5, step: 1)
                    .accentColor(color)
                Text("\(Int(priority))")
                    .font(.caption)
                    .bold()
                    .foregroundColor(color)
                    .frame(width: 20)
            }
        }
    }
}

#Preview {
    LayoutInteractionDemoView()
}

