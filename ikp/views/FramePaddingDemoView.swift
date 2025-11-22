//
//  FramePaddingDemoView.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/23.
//

import SwiftUI

struct FramePaddingDemoView: View {
    @State private var paddingAmount: CGFloat = 20
    @State private var frameSize: CGFloat = 150
    @State private var paddingFirst: Bool = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                Text("Frame & Padding 顺序")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                Text("直观展示修饰符顺序对布局的影响")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // 演示区域
                ZStack {
                    // 背景网格，帮助观察对齐
                    GridShape()
                        .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                    
                    if paddingFirst {
                        // 顺序 1: Padding -> Frame
                        // 先加内边距（变大），再限制在 Frame 中（可能被切断或留白）
                        InnerContentView()
                            .padding(paddingAmount)
                            .background(Color.green.opacity(0.3)) // 绿色表示 Padding 区域
                            .overlay(
                                Text("Padding: \(Int(paddingAmount))")
                                    .font(.caption2)
                                    .foregroundColor(.green)
                                    .offset(y: -paddingAmount/2 - 10),
                                alignment: .top
                            )
                            .frame(width: frameSize, height: frameSize)
                            .background(Color.red.opacity(0.2))   // 红色表示 Frame 区域
                            .border(Color.red, width: 2)
                            .overlay(
                                Text("Frame: \(Int(frameSize))")
                                    .font(.caption2)
                                    .foregroundColor(.red)
                                    .offset(y: frameSize/2 + 10),
                                alignment: .bottom
                            )
                            
                    } else {
                        // 顺序 2: Frame -> Padding
                        // 先限制 Frame（固定大小），再在外面加 Padding（整体变大）
                        InnerContentView()
                            .frame(width: frameSize, height: frameSize)
                            .background(Color.red.opacity(0.2))   // 红色表示 Frame 区域
                            .border(Color.red, width: 2)
                            .overlay(
                                Text("Frame: \(Int(frameSize))")
                                    .font(.caption2)
                                    .foregroundColor(.red)
                                    .offset(y: -frameSize/2 - 10),
                                alignment: .top
                            )
                            .padding(paddingAmount)
                            .background(Color.green.opacity(0.3)) // 绿色表示 Padding 区域
                            .overlay(
                                Text("Padding: \(Int(paddingAmount))")
                                    .font(.caption2)
                                    .foregroundColor(.green)
                                    .offset(y: paddingAmount/2 + 10),
                                alignment: .bottom
                            )
                    }
                }
                .frame(height: 350)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.05), radius: 5)
                .padding(.horizontal)
                
                // 图例
                HStack(spacing: 15) {
                    LegendItem(color: .blue, text: "内容")
                    LegendItem(color: .green.opacity(0.5), text: "Padding层")
                    LegendItem(color: .red.opacity(0.3), text: "Frame层")
                }
                .font(.caption)
                
                // 控制面板
                VStack(alignment: .leading, spacing: 20) {
                    // 顺序切换
                    Toggle(isOn: $paddingFirst.animation()) {
                        VStack(alignment: .leading) {
                            Text("修饰符顺序")
                                .font(.headline)
                            Text(paddingFirst ? "当前: .padding() -> .frame()" : "当前: .frame() -> .padding()")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    // 滑块
                    VStack(spacing: 15) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Padding")
                                Spacer()
                                Text("\(Int(paddingAmount))")
                                    .monospacedDigit()
                                    .foregroundColor(.green)
                            }
                            Slider(value: $paddingAmount, in: 0...100)
                                .accentColor(.green)
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Frame Size")
                                Spacer()
                                Text("\(Int(frameSize))")
                                    .monospacedDigit()
                                    .foregroundColor(.red)
                            }
                            Slider(value: $frameSize, in: 50...300)
                                .accentColor(.red)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    // 代码预览
                    VStack(alignment: .leading, spacing: 8) {
                        Text("SwiftUI 代码:")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("""
                        Text("Hello")
                            .background(.blue)
                        \(paddingFirst ? "    .padding(\(Int(paddingAmount)))" : "    .frame(width: \(Int(frameSize)), height: \(Int(frameSize)))")
                        \(paddingFirst ? "    .frame(width: \(Int(frameSize)), height: \(Int(frameSize)))" : "    .padding(\(Int(paddingAmount)))")
                        """)
                        .font(.system(.caption, design: .monospaced))
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.black.opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}

struct InnerContentView: View {
    var body: some View {
        Text("Hello")
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 60, height: 60)
            .background(Color.blue)
            .cornerRadius(8)
    }
}

struct LegendItem: View {
    var color: Color
    var text: String
    
    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(color)
                .frame(width: 10, height: 10)
            Text(text)
        }
    }
}

// 简单的网格背景
struct GridShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let step: CGFloat = 20
        
        for x in stride(from: 0, to: rect.width, by: step) {
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x, y: rect.height))
        }
        
        for y in stride(from: 0, to: rect.height, by: step) {
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: rect.width, y: y))
        }
        
        return path
    }
}

#Preview {
    FramePaddingDemoView()
}

