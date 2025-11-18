//
//  EventDemoView.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/18.
//

import SwiftUI

struct EventDemoView: View {
    @Environment(\.scenePhase) var scenePhase
    @State private var toastMessage: String = ""
    @State private var showToast: Bool = false
    @State private var dismissWorkItem: DispatchWorkItem?

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 16) {
                Text("Scene Phase 状态示例")
                    .font(.title)
                    .padding(.top, 80)
                Text("切换 App 前后台状态，查看顶部提示。")
                    .font(.body)
                    .foregroundColor(.secondary)
            }

            if showToast {
                // 展示一个提示
                Text(toastMessage)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.black.opacity(0.75))
                    .cornerRadius(12)
                    .padding(.top, 40)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .animation(
            .spring(response: 0.35, dampingFraction: 0.85),
            value: showToast
        )
        .onChange(of: scenePhase) { _, newPhase in
            handlePhaseChange(newPhase)
        }
    }

    private func handlePhaseChange(_ phase: ScenePhase) {
        let message: String
        switch phase {
        case .active:
            message = "App 已激活"
        case .inactive:
            message = "App 处于非活跃状态"
        case .background:
            message = "App 已进入后台"
        @unknown default:
            message = "App 状态未知"
        }

        dismissWorkItem?.cancel()
        withAnimation {
            toastMessage = message
            showToast = true
        }

        let workItem = DispatchWorkItem {
            withAnimation {
                showToast = false
            }
        }
        dismissWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: workItem)
    }
}

#Preview {
    EventDemoView()
}
