//
//  StateDemo3View.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/23.
//

import SwiftUI
import Combine

class Player: ObservableObject {
    @Published var name: String = "John"
    @Published var score: Int = 0
}

struct StateDemo3View: View {
    // @StateObject 用于在 View 中创建和拥有 ObservableObject 实例
    // 当 View 重新创建时，@StateObject 会保持同一个实例
    @StateObject private var player = Player()

    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                Text("StateObject 示例")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                
                // 玩家信息卡片
                VStack(spacing: 15) {
                    Text("玩家档案")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("姓名")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(player.name)
                                .font(.title2)
                                .bold()
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("当前分数")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("\(player.score)")
                                .font(.system(size: 36, weight: .heavy, design: .rounded))
                                .foregroundColor(.blue)
                        }
                    }
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                .padding(.horizontal)
                
                // 操作区域
                VStack(spacing: 15) {
                    // 修改姓名按钮
                    Button(action: {
                        withAnimation {
                            player.name = player.name == "John" ? "Jane" : "John"
                        }
                    }) {
                        HStack {
                            Image(systemName: "person.arrow.triangle.2.circlepath")
                            Text("切换玩家姓名")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(12)
                    }
                    
                    HStack(spacing: 15) {
                        // 增加分数
                        Button(action: {
                            withAnimation(.spring()) {
                                player.score += 10
                            }
                        }) {
                            VStack {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                Text("加分")
                                    .font(.headline)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(12)
                        }
                        
                        // 重置分数
                        Button(action: {
                            withAnimation {
                                player.score = 0
                            }
                        }) {
                            VStack {
                                Image(systemName: "arrow.counterclockwise.circle.fill")
                                    .font(.title2)
                                Text("重置")
                                    .font(.headline)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(12)
                        }
                    }
                }
                .padding(.horizontal)
                
                // 子视图区域
                VStack(alignment: .leading, spacing: 10) {
                    Text("子视图观察区域")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.leading, 5)
                    
                    PlayerNameView(player: player)
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .background(Color(UIColor.systemGroupedBackground)) // 使用系统背景色
    }
}

// 子视图使用 @ObservedObject 接收从父视图的 @StateObject 传递的对象
struct PlayerNameView: View {
    @ObservedObject var player: Player
    
    var body: some View {
        HStack {
            Image(systemName: "eye")
                .foregroundColor(.secondary)
            Text("子视图同步显示:")
                .font(.subheadline)
                .foregroundColor(.primary)
            Spacer()
            Text(player.name)
                .font(.headline)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.blue.opacity(0.1))
                .foregroundColor(.blue)
                .cornerRadius(8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    StateDemo3View()
}
