//
//  ComplexStackDemoView.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/23.
//

import SwiftUI

struct ComplexStackDemoView: View {
    
    // 定义辅助枚举以支持 Picker 选择
    enum CardAlignment: String, CaseIterable, Identifiable {
        case leading = "Leading"
        case center = "Center"
        case trailing = "Trailing"
        
        var id: String { self.rawValue }
        
        var value: HorizontalAlignment {
            switch self {
            case .leading: return .leading
            case .center: return .center
            case .trailing: return .trailing
            }
        }
    }
    
    // 状态控制
    @State private var showLayoutStructure: Bool = false
    @State private var cardAlignment: CardAlignment = .leading
    @State private var contentSpacing: CGFloat = 8
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // 标题
                VStack(spacing: 5) {
                    Text("Stack 组合布局")
                        .font(.title2)
                        .bold()
                    Text("VStack + HStack + ZStack 综合实战")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top)
                
                // --- 核心演示卡片 ---
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("实战案例：旅游卡片")
                            .font(.headline)
                        Spacer()
                        if showLayoutStructure {
                            Text("透视模式开启")
                                .font(.caption)
                                .foregroundColor(.purple)
                                .bold()
                                .padding(4)
                                .background(Color.purple.opacity(0.1))
                                .cornerRadius(4)
                        }
                    }
                    .padding(.horizontal)
                    
                    // 卡片容器
                    ZStack {
                        // 模拟卡片阴影和背景
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                        
                        // 卡片内容
                        VStack(alignment: .leading, spacing: 0) {
                            // 上半部分：图片区域 (ZStack 使用场景)
                            headerImageArea
                            
                            // 下半部分：信息区域 (VStack + HStack 使用场景)
                            contentInfoArea
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .frame(height: 400)
                    .padding(.horizontal)
                }
                
                // --- 控制面板 ---
                VStack(spacing: 20) {
                    // 透视开关
                    Toggle(isOn: $showLayoutStructure.animation()) {
                        HStack {
                            Image(systemName: "square.stack.3d.down.right.fill")
                                .foregroundColor(.purple)
                            VStack(alignment: .leading) {
                                Text("布局透视模式")
                                    .font(.headline)
                                Text("高亮显示 Stack 嵌套结构")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    
                    // 对齐控制
                    if !showLayoutStructure {
                        VStack(alignment: .leading) {
                            Text("内容对齐 (VStack Alignment)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Picker("Alignment", selection: $cardAlignment.animation()) {
                                ForEach(CardAlignment.allCases) { alignment in
                                    Text(alignment.rawValue).tag(alignment)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("内容间距 (Spacing)")
                                Spacer()
                                Text("\(Int(contentSpacing))")
                                    .monospacedDigit()
                            }
                            .font(.caption)
                            .foregroundColor(.secondary)
                            
                            Slider(value: $contentSpacing, in: 0...30)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                // --- 结构图例 ---
                if showLayoutStructure {
                    HStack(spacing: 15) {
                        LegendView(color: .red, text: "ZStack (层叠)")
                        LegendView(color: .blue, text: "VStack (垂直)")
                        LegendView(color: .green, text: "HStack (水平)")
                    }
                    .font(.caption)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                }
                
                Spacer(minLength: 50)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
    
    // MARK: - 子视图组件
    
    // 上半部分：图片和悬浮按钮 (ZStack 演示)
    var headerImageArea: some View {
        debugZStack {
            // 1. 底层：图片背景
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.6), .purple.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .overlay(
                    Image(systemName: "mountain.2.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .foregroundColor(.white.opacity(0.3))
                )
            
            // 2. 顶层左上：标签
            VStack {
                HStack {
                    Text("热门景点")
                        .font(.caption)
                        .bold()
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .shadow(radius: 2)
                    Spacer()
                }
                Spacer()
            }
            .padding(12)
            
            // 3. 顶层右下：收藏按钮
            // 这里巧妙利用 ZStack 放置在右下角，并下沉一半
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "heart.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Circle().fill(Color.pink))
                            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                    }
                }
            }
            .padding(16)
            .offset(y: 30) // 让按钮下沉，突出边界
        }
        // 确保 ZStack 内部视图不会被裁剪（除了整体卡片的圆角）
        .zIndex(1) // 提高层级，保证按钮浮在下方内容之上
    }
    
    // 下半部分：文字信息 (VStack & HStack 演示)
    var contentInfoArea: some View {
        debugVStack(alignment: cardAlignment.value, spacing: contentSpacing) {
            // 标题
            Text("瑞士阿尔卑斯山脉")
                .font(.title)
                .bold()
//                .padding(.top, 10) // 留出空间给悬浮按钮
            
            // 地点 (HStack)
            debugHStack {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(.red)
                Text("瑞士 · 伯尔尼")
                    .foregroundColor(.secondary)
            }
            .font(.subheadline)
            
            // 标签行 (HStack)
            debugHStack {
                TagView(text: "自然风光")
                TagView(text: "滑雪胜地")
                TagView(text: "徒步")
            }
            .padding(.vertical, 5)
            
            Divider()
            
            // 底部价格栏 (HStack + Spacer)
            debugHStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("参考价格")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    HStack(alignment: .firstTextBaseline, spacing: 2) {
                        Text("¥")
                            .font(.caption)
                            .foregroundColor(.blue)
                        Text("2,499")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.blue)
                        Text("/人起")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                Button(action: {}) {
                    Text("立即预订")
                        .bold()
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.top, 5)
        }
        .padding(20)
        .background(Color.white)
        .zIndex(0)
    }
    
    // MARK: - 调试辅助视图
    // 这些包装器函数根据开关状态决定是否添加边框
    
    func debugZStack<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        ZStack {
            content()
        }
        .overlay(
            showLayoutStructure ? 
                ZStack(alignment: .topLeading) {
                    Rectangle().stroke(Color.red, lineWidth: 2)
                    Text("ZStack").font(.caption2).bold().padding(2).background(Color.red).foregroundColor(.white)
                } : nil
        )
    }
    
    func debugVStack<Content: View>(alignment: HorizontalAlignment, spacing: CGFloat, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: alignment, spacing: spacing) {
            content()
        }
        .overlay(
            showLayoutStructure ? 
                ZStack(alignment: .top) {
                    Rectangle().stroke(Color.blue, lineWidth: 2)
                    Text("VStack").font(.caption2).bold().padding(2).background(Color.blue).foregroundColor(.white).offset(y: -10)
                } : nil
        )
    }
    
    func debugHStack<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        HStack {
            content()
        }
        .overlay(
            showLayoutStructure ? 
                ZStack(alignment: .bottom) {
                    Rectangle().stroke(Color.green, lineWidth: 2)
                    Text("HStack").font(.caption2).bold().padding(2).background(Color.green).foregroundColor(.white).offset(y: 10)
                } : nil
        )
    }
}

struct TagView: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(4)
            .foregroundColor(.secondary)
    }
}

struct LegendView: View {
    let color: Color
    let text: String
    var body: some View {
        HStack(spacing: 4) {
            Circle().fill(color).frame(width: 8, height: 8)
            Text(text)
        }
    }
}

#Preview {
    ComplexStackDemoView()
}

