//
//  ContentView.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/4.
//

import SwiftUI

// 示例页面数据模型
struct ExamplePage: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
    let destination: AnyView

    init<Content: View>(
        title: String,
        description: String,
        icon: String,
        @ViewBuilder destination: () -> Content
    ) {
        self.title = title
        self.description = description
        self.icon = icon
        self.destination = AnyView(destination())
    }
}

// UI 示例列表视图
struct UIExamplesView: View {
    // 示例页面列表
    let examplePages: [ExamplePage] = [
        ExamplePage(
            title: "文本示例",
            description: "基础文本样式和格式化示例",
            icon: "textformat"
        ) {
            TextExamplesView()
        },
        ExamplePage(
            title: "文本对齐",
            description: "文本对齐、间距和格式示例",
            icon: "text.alignleft"
        ) {
            TextAlignmentView()
        },
        ExamplePage(
            title: "布局演示",
            description: "VStack、HStack 和 GeometryReader 布局示例",
            icon: "square.grid.2x2"
        ) {
            LayoutDemoView()
        },
        ExamplePage(
            title: "堆栈布局",
            description: "VStack、HStack 和 Spacer 示例",
            icon: "square.stack.3d.up"
        ) {
            StackDemoView()
        },
        ExamplePage(
            title: "ZStack 演示",
            description: "ZStack 层叠布局示例",
            icon: "square.stack"
        ) {
            ZStackDemoView()
        },
        ExamplePage(
            title: "滚动视图",
            description: "ScrollView 和 ScrollViewReader 示例",
            icon: "arrow.up.arrow.down"
        ) {
            ScrollDemoView()
        },
        ExamplePage(
            title: "网格视图",
            description: "LazyVGrid 和 LazyHGrid 网格布局示例",
            icon: "grid"
        ) {
            LazyVHGridView()
        },
        ExamplePage(
            title: "拖动手势",
            description: "DragGesture 拖动手势交互示例",
            icon: "hand.draw"
        ) {
            DragGestureView()
        },
    ]

    var body: some View {
        List {
            Section(header: Text("SwiftUI 示例")) {
                ForEach(examplePages) { page in
                    NavigationLink(destination: page.destination) {
                        HStack {
                            Image(systemName: page.icon)
                                .foregroundColor(.blue)
                                .frame(width: 30)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(page.title)
                                    .font(.headline)
                                Text(page.description)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("UI 示例")
        .listStyle(InsetGroupedListStyle())
    }
}

// 状态管理示例列表视图
struct StateExamplesView: View {
    // 状态管理示例页面列表
    let statePages: [ExamplePage] = [
        ExamplePage(
            title: "状态控制演示",
            description: "@State、状态切换和 ContentShape 示例",
            icon: "slider.horizontal.3"
        ) {
            StateDemoView()
        },

        ExamplePage(
            title: "状态控制演示2",
            description: "日期选择器、",
            icon: "slider.horizontal.3"
        ) {
            StateDemo2View()
        },
        ExamplePage(
            title: "状态控制演示3",
            description: "@ObservedObject",
            icon: "slider.horizontal.3"
        ) {
            StateDemo3View()
        },
        ExamplePage(
            title: "状态控制演示3",
            description: "@ObservedObject",
            icon: "slider.horizontal.3"
        ) {
            StateDemo3View()
        },
    ]

    var body: some View {
        List {
            Section(header: Text("状态管理")) {
                ForEach(statePages) { page in
                    NavigationLink(destination: page.destination) {
                        HStack {
                            Image(systemName: page.icon)
                                .foregroundColor(.green)
                                .frame(width: 30)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(page.title)
                                    .font(.headline)
                                Text(page.description)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("State 示例")
        .listStyle(InsetGroupedListStyle())
    }
}

// 状态管理示例列表视图
struct EventExamplesView: View {
    // 状态管理示例页面列表
    let statePages: [ExamplePage] = [
        ExamplePage(
            title: "事件示例",
            description: "onChange",
            icon: "slider.horizontal.3"
        ) {
            EventDemoView()
        },
        ExamplePage(
            title: "生命周期示例",
            description: "生命周期",
            icon: "clock.arrow.2.circlepath"
        ) {
            LifeCycleDemoView()
        },
    ]

    var body: some View {
        List {
            Section(header: Text("状态管理")) {
                ForEach(statePages) { page in
                    NavigationLink(destination: page.destination) {
                        HStack {
                            Image(systemName: page.icon)
                                .foregroundColor(.green)
                                .frame(width: 30)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(page.title)
                                    .font(.headline)
                                Text(page.description)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("State 示例")
        .listStyle(InsetGroupedListStyle())
    }
}

// 主视图
struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // UI 示例入口
                    NavigationLink(destination: UIExamplesView()) {
                        CategoryCard(
                            title: "UI 示例",
                            description: "SwiftUI 布局、文本、手势等 UI 组件示例",
                            icon: "square.grid.2x2",
                            color: .blue
                        )
                    }
                    .buttonStyle(PlainButtonStyle())

                    // State 示例入口
                    NavigationLink(destination: StateExamplesView()) {
                        CategoryCard(
                            title: "State 示例",
                            description: "状态管理、数据绑定等示例",
                            icon: "slider.horizontal.3",
                            color: .green
                        )
                    }
                    .buttonStyle(PlainButtonStyle())

                    // Event 示例入口
                    NavigationLink(destination: EventExamplesView()) {
                        CategoryCard(
                            title: "Event示例",
                            description: "响应事件示例、用户点击和手势",
                            icon: "hand.tap",
                            color: .orange
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
            }
            .navigationTitle("SwiftUI 示例集合")
        }
    }
}

// 分类卡片组件
struct CategoryCard: View {
    let title: String
    let description: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(color)
                .frame(width: 60, height: 60)
                .background(color.opacity(0.1))
                .cornerRadius(12)

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 2)
    }
}

#Preview {
    ContentView()
}
