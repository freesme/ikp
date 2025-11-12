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

// 必须符合protocol View
struct ContentView: View {
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
        NavigationView {
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
            .navigationTitle("SwiftUI 示例集合")
            .listStyle(InsetGroupedListStyle())
        }
    }
}

#Preview {
    ContentView()
}
