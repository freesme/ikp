//
//  LiveCycleDemoView.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/18.
//

import SwiftUI

struct LifeCycleDemoView: View {
    @State private var logs: [LifecycleLog] = []
    @State private var appearCount: Int = 0
    @State private var disappearCount: Int = 0
    @AppStorage("name") var name = "匿名"
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                Text("UserDefaultName: \(name)")
                summaryCard
                NavigationLink {
                    DetailView { event in
                        recordLifecycle(viewName: "详情页", event: event)
                    }
                } label: {
                    Label("进入详情页以触发生命周期", systemImage: "arrow.right.circle")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor.opacity(0.15))
                        .cornerRadius(12)
                }

                logSection

                Spacer()
            }
            .padding()
            .navigationTitle("生命周期演示")
        }
        .onAppear {
            recordLifecycle(viewName: "主页面", event: .appear)
        }
        .onDisappear {
            recordLifecycle(viewName: "主页面", event: .disappear)
        }
    }

    private var summaryCard: some View {
        HStack(spacing: 16) {
            SummaryItem(title: "出现次数", value: "\(appearCount)", color: .green)
            SummaryItem(
                title: "消失次数",
                value: "\(disappearCount)",
                color: .orange
            )
        }
    }

    private var logSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("实时事件日志")
                .font(.headline)

            if logs.isEmpty {
                Text("暂无事件，点击上方按钮或切换页面触发生命周期。")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(logs) { log in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(log.message)
                                    .font(.body)
                                Text(
                                    log.timestamp.formatted(
                                        date: .omitted,
                                        time: .standard
                                    )
                                )
                                .font(.caption)
                                .foregroundColor(.secondary)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemBackground))
                            .cornerRadius(10)
                            .shadow(
                                color: .black.opacity(0.05),
                                radius: 4,
                                x: 0,
                                y: 2
                            )
                        }
                    }
                }
                .frame(maxHeight: 300)
            }
        }
    }

    private func recordLifecycle(viewName: String, event: LifecycleEvent) {
        switch event {
        case .appear:
            appearCount += 1
        case .disappear:
            disappearCount += 1
        }
        appendLog("\(viewName) \(event.rawValue)")
    }

    private func appendLog(_ message: String) {
        withAnimation {
            logs.insert(LifecycleLog(message: message), at: 0)
            if logs.count > 20 {
                logs.removeLast()
            }
        }
    }
}

struct SummaryItem: View {
    let title: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(color)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 3)
    }
}

struct DetailView: View {
    let onEvent: (LifecycleEvent) -> Void

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "rectangle.stack.person.crop")
                .font(.system(size: 60))
                .foregroundColor(.accentColor)
            Text("这是详情页")
                .font(.title2)
            Text("当你进入或离开此页面时，下方日志会记录 onAppear / onDisappear 事件。")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .padding()
        .navigationTitle("详情页")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            onEvent(.appear)
        }
        .onDisappear {
            onEvent(.disappear)
        }
    }
}

enum LifecycleEvent: String {
    case appear = "onAppear"
    case disappear = "onDisappear"
}

struct LifecycleLog: Identifiable {
    let id = UUID()
    let message: String
    let timestamp: Date = Date()
}

#Preview {
    LifeCycleDemoView()
}
