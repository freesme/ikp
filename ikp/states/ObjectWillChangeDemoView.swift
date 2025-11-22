//
//  ObjectWillChangeDemoView.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/23.
//

import SwiftUI
import Combine

// 1. 不使用 @Published，而是手动控制更新
// 这种方式适用于需要精细控制 UI 刷新时机，或者属性之间有依赖关系需要批量更新的场景
class ManualCounter: ObservableObject {
    // 普通属性，没有 @Published
    var count: Int = 0 {
        willSet {
            // 2. 在值改变前手动发送通知
            // 演示条件更新：只有当新值是偶数时才通知视图更新
            // 这意味着当 count 从 0 变 1 时，视图不会刷新，显示仍为 0
            // 当 count 从 1 变 2 时，视图刷新，直接显示 2
            if newValue % 2 == 0 {
                print("Sending update for even number: \(newValue)")
                objectWillChange.send()
            }
        }
    }
    
    // 另一个示例：手动控制刷新
    var data1: String = ""
    var data2: String = ""
    
    func updateDataSilently() {
        // 修改数据但不发送通知
        data1 = "Silent Update"
        data2 = "\(Date())"
        print("Data updated silently")
    }
    
    func manualRefresh() {
        // 仅发送通知，触发视图重绘，此时会读取到最新的 data1 和 data2
        objectWillChange.send()
    }
    
    func updateDataWithNotification() {
        // 标准模式：发送通知后修改数据
        objectWillChange.send()
        data1 = "Normal Update"
        data2 = "\(Date())"
    }
}

struct ObjectWillChangeDemoView: View {
    @StateObject private var counter = ManualCounter()
    @State private var currentPage = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // 主要内容区域
            TabView(selection: $currentPage) {
                // 页面 1: 文档说明
                DocumentationView()
                    .tag(0)
                    // 增加底部内边距，防止内容被 TabBar 遮挡
                    .padding(.bottom, 80)
                
                // 页面 2: 示例演示
                DemoContentView(counter: counter)
                    .tag(1)
                    .padding(.bottom, 80)
            }
            .tabViewStyle(.page(indexDisplayMode: .never)) // 保持滑动手势，但隐藏系统指示器
            .edgesIgnoringSafeArea(.bottom) // 让内容延伸到底部
            
            // 自定义底部 Tab Bar
            CustomTabBar(selection: $currentPage)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .ignoresSafeArea(.keyboard) // 防止键盘弹起时 TabBar 上移
    }
}

// MARK: - 自定义底部导航栏
struct CustomTabBar: View {
    @Binding var selection: Int
    @Namespace private var animationNamespace
    
    var body: some View {
        HStack(spacing: 0) {
            TabBarItem(
                title: "原理文档",
                icon: "doc.text",
                selectedIcon: "doc.text.fill",
                tag: 0,
                selection: $selection,
                namespace: animationNamespace
            )
            
            TabBarItem(
                title: "示例演示",
                icon: "play.circle",
                selectedIcon: "play.circle.fill",
                tag: 1,
                selection: $selection,
                namespace: animationNamespace
            )
        }
        .padding(.top, 12)
        .padding(.bottom, 0) // 移除额外间距，让其紧贴安全区域
        .background(
            Color.white
                .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: -2)
                .edgesIgnoringSafeArea(.bottom) // 让背景延伸至屏幕最底部
        )
    }
}

// 单个 Tab 按钮
struct TabBarItem: View {
    let title: String
    let icon: String
    let selectedIcon: String
    let tag: Int
    @Binding var selection: Int
    var namespace: Namespace.ID
    
    var isSelected: Bool {
        selection == tag
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selection = tag
            }
        }) {
            VStack(spacing: 4) {
                ZStack {
                    // 这里使用条件渲染来切换图标，实现简单的动画效果
                    if isSelected {
                        Image(systemName: selectedIcon)
                            .font(.system(size: 24))
                            .foregroundColor(.blue)
                            // 使用 matchedGeometryEffect 或 scale 动画
                            .scaleEffect(1.1)
                    } else {
                        Image(systemName: icon)
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                    }
                }
                .frame(height: 24)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(isSelected ? .semibold : .regular)
                    .foregroundColor(isSelected ? .blue : .gray)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle()) // 扩大点击区域
        }
    }
}

// MARK: - 演示内容视图
struct DemoContentView: View {
    @ObservedObject var counter: ManualCounter
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("objectWillChange 示例")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                Text("手动控制视图更新时机")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // 示例 1: 条件更新
                VStack(spacing: 20) {
                    Text("条件更新计数器")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                    
                    VStack {
                        Text("当前显示值")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("\(counter.count)")
                            .font(.system(size: 60, weight: .bold, design: .rounded))
                            .foregroundColor(counter.count % 2 == 0 ? .blue : .orange)
                            .contentTransition(.numericText(value: Double(counter.count)))
                    }
                    .padding()
                    
                    Text("说明：内部值每次点击都会+1，但只有**偶数**时才会触发 UI 刷新。")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .background(Color.yellow.opacity(0.1))
                        .cornerRadius(8)
                    
                    Button(action: {
                        counter.count += 1
                        print("Button clicked. Current internal count: \(counter.count)")
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("增加计数 (+1)")
                        }
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                    }
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                
                // 示例 2: 手动刷新控制
                VStack(spacing: 20) {
                    Text("手动刷新控制")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Data 1")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(counter.data1.isEmpty ? "-" : counter.data1)
                                .font(.headline)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Data 2")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(counter.data2.isEmpty ? "-" : counter.data2)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    
                    VStack(spacing: 12) {
                        Button(action: {
                            counter.updateDataSilently()
                        }) {
                            Text("1. 静默修改数据 (无刷新)")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(Color.orange.opacity(0.1))
                                .foregroundColor(.orange)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            counter.manualRefresh()
                        }) {
                            Text("2. 手动触发刷新 (显示数据)")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(Color.purple.opacity(0.1))
                                .foregroundColor(.purple)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            counter.updateDataWithNotification()
                        }) {
                            Text("3. 同时修改并刷新")
                                .bold()
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                
                Spacer()
            }
            .padding()
        }
    }
}

// MARK: - 文档视图
struct DocumentationView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Image(systemName: "doc.text.fill")
                        .foregroundColor(.blue)
                    Text("关于 objectWillChange")
                        .font(.title2)
                        .bold()
                }
                .padding(.top)
                
                Group {
                    // 原理卡片
                    VStack(alignment: .leading, spacing: 10) {
                        Text("原理")
                            .font(.headline)
                            .foregroundColor(.blue)
                        Divider()
                        Text("`objectWillChange` 是 ObservableObject 协议的一部分。当你调用 `send()` 方法时，它会向所有订阅该对象的视图发送变更通知，告诉它们即将有数据发生变化，需要准备重新渲染。")
                            .font(.body)
                            .foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    
                    // 区别卡片
                    VStack(alignment: .leading, spacing: 10) {
                        Text("与 @Published 的区别")
                            .font(.headline)
                            .foregroundColor(.blue)
                        Divider()
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(alignment: .top) {
                                Text("•")
                                Text("@Published：自动封装了 `willSet`，在属性值变化前自动调用 `send()`。")
                            }
                            HStack(alignment: .top) {
                                Text("•")
                                Text("手动调用：让你完全掌控发送通知的时机，不再局限于属性赋值那一刻。")
                            }
                        }
                        .font(.body)
                        .foregroundColor(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    
                    // 场景卡片
                    VStack(alignment: .leading, spacing: 10) {
                        Text("适用场景")
                            .font(.headline)
                            .foregroundColor(.blue)
                        Divider()
                        Text("1. **性能优化**：当有大量属性同时变化时，可以只发送一次通知，而不是每个属性变化都发送。\n\n2. **条件更新**：如本例所示，只在满足特定条件（如偶数）时才更新视图。\n\n3. **计算属性**：当视图依赖于复杂的计算属性或外部非响应式数据源时。")
                            .font(.body)
                            .foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ObjectWillChangeDemoView()
}
