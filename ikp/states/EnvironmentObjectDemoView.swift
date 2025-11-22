//
//  EnvironmentObjectDemoView.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/23.
//

import SwiftUI
import Combine

// 1. 定义一个遵循 ObservableObject 的类，作为全局状态
class UserSettings: ObservableObject {
    @Published var username: String = "Guest"
    @Published var isLoggedIn: Bool = false
    @Published var themeColor: Color = .blue
}

struct EnvironmentObjectDemoView: View {
    // 创建状态对象实例
    @StateObject private var settings = UserSettings()
    
    var body: some View {
        // 2. 通过 environmentObject 注入到视图层级中
        // 注意：通常这个注入操作会在 App 的根视图或某个主要导航视图上进行
        MainContentView()
            .environmentObject(settings)
    }
}

struct MainContentView: View {
    // 这里不需要接收 settings，直接在子视图中使用
    // 即使中间隔了很多层 View，只要在最顶层注入了，下面的子 View 都能取到
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    Text("EnvironmentObject 示例")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                    
                    Text("跨层级数据共享")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // 显示当前状态的卡片
                    StatusCardView()
                    
                    // 设置区域
                    SettingsControlView()
                    
                    Spacer()
                }
                .padding()
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("主页")
            .navigationBarHidden(true)
        }
    }
}

// 3. 子视图使用 @EnvironmentObject 获取共享数据
struct StatusCardView: View {
    // 自动从环境中查找 UserSettings 类型的对象
    // 如果环境中没有注入该对象，这里会导致 Crash，所以一定要确保上层有 .environmentObject(settings)
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Image(systemName: settings.isLoggedIn ? "person.circle.fill" : "person.circle")
                    .font(.system(size: 50))
                    .foregroundColor(settings.themeColor)
                
                VStack(alignment: .leading) {
                    Text(settings.username)
                        .font(.title2)
                        .bold()
                    Text(settings.isLoggedIn ? "在线" : "离线")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// 另一个深层子视图，同样可以直接访问，无需通过中间层传递
struct SettingsControlView: View {
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        VStack(spacing: 20) {
            Text("设置面板")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if settings.isLoggedIn {
                // 修改用户名
                VStack(alignment: .leading) {
                    Text("用户名")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    TextField("输入用户名", text: $settings.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // 修改主题色
                ColorPicker("主题颜色", selection: $settings.themeColor)
                
                Divider()
                
                // 登出按钮
                Button(action: {
                    withAnimation {
                        settings.isLoggedIn = false
                        settings.username = "Guest"
                        settings.themeColor = .blue
                    }
                }) {
                    Text("退出登录")
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
            } else {
                Text("请登录以修改设置")
                    .foregroundColor(.secondary)
                    .italic()
                    .padding(.vertical)
                
                // 登录按钮
                Button(action: {
                    withAnimation {
                        settings.isLoggedIn = true
                        settings.username = "User_\(Int.random(in: 1000...9999))"
                    }
                }) {
                    Text("登录")
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    EnvironmentObjectDemoView()
}

