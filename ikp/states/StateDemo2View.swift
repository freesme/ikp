//
//  StateDemo2View.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/14.
//


//
//  StateDemo2View.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/14.
//

import SwiftUI

struct StateDemo2View: View {

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()

    @State private var birthDate = Date()

    @State private var favoriteColor = 0
    
    @State private var quantity = 1
    
    @State private var textContent = "在这里输入文本..."

    private var favoriteColorInfo: (name: String, color: Color) {
        switch favoriteColor {
        case 0:
            return ("红色", Color.red)
        case 1:
            return ("绿色", Color.green)
        case 2:
            return ("蓝色", Color.blue)
        default:
            return ("默认", Color.gray)
        }
    }

    var body: some View {
        ZStack {
            // 背景渐变
            LinearGradient(
                colors: [
                    Color(red: 0.95, green: 0.97, blue: 1.0),
                    Color(red: 0.98, green: 0.99, blue: 1.0)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // 标题区域
                    VStack(spacing: 8) {
                        Text("简单的状态控制-2")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        Text("SwiftUI 状态管理示例")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    
                    // 日期选择器卡片
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 10) {
                            Image(systemName: "calendar")
                                .font(.title2)
                                .foregroundStyle(.blue)
                            Text("日期选择器")
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                        
                        DatePicker(
                            selection: $birthDate,
                            in: ...Date(),
                            displayedComponents: .date
                        ) {
                            Text("选择日期")
                                .foregroundStyle(.secondary)
                        }
                        .datePickerStyle(.compact)

                        HStack {
                            Image(systemName: "clock.fill")
                                .font(.caption)
                                .foregroundStyle(.blue.opacity(0.7))
                            Text("Date is \(birthDate, formatter: dateFormatter)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.top, 4)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
                    )
                
                    // 步进器卡片
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 10) {
                            Image(systemName: "plusminus.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.green)
                            Text("步进器")
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                        
                        Stepper(
                            value: $quantity,
                            in: 1...100,
                            step: 1
                        ) {
                            HStack {
                                Text("数量：")
                                    .foregroundStyle(.secondary)
                                Spacer()
                                Text("\(quantity)")
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [.green, .mint],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                            }
                        }
                        .tint(.green)
                        
                        HStack {
                            Image(systemName: "number.circle.fill")
                                .font(.caption)
                                .foregroundStyle(.green.opacity(0.7))
                            Text("当前值：\(quantity)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.top, 4)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
                    )
                
                    // 文本编辑器卡片
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 10) {
                            Image(systemName: "text.alignleft")
                                .font(.callout)
                                .foregroundStyle(.orange)
                            Text("文本编辑器")
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                        
                        TextEditor(text: $textContent)
                            .frame(minHeight: 140)
                            .padding(12)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color(red: 0.98, green: 0.98, blue: 0.99))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(
                                        LinearGradient(
                                            colors: [.orange.opacity(0.3), .orange.opacity(0.1)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 1.5
                                    )
                            )
                            .scrollContentBackground(.hidden)
                        
                        HStack {
                            HStack(spacing: 6) {
                                Image(systemName: "textformat.123")
                                    .font(.caption2)
                                Text("字符数：\(textContent.count)")
                                    .font(.caption)
                            }
                            .foregroundStyle(.secondary)
                            
                            Spacer()
                            
                            if textContent.isEmpty || textContent == "在这里输入文本..." {
                                HStack(spacing: 6) {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .font(.caption2)
                                    Text("文本为空")
                                        .font(.caption)
                                }
                                .foregroundStyle(.orange)
                            }
                        }
                        .padding(.top, 4)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
                    )

                    // 颜色选择器卡片
                    VStack(alignment: .leading, spacing: 18) {
                        HStack(spacing: 10) {
                            Image(systemName: "paintpalette.fill")
                                .font(.title2)
                                .foregroundStyle(.white)
                            Text("颜色选择器")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                        }
                        
                        Picker(
                            selection: $favoriteColor,
                            label: Text("What is your favorite color?")
                        ) {
                            Text("Red").tag(0)
                            Text("Green").tag(1)
                            Text("Blue").tag(2)
                        }
                        .pickerStyle(.segmented)
                        .animation(.easeInOut(duration: 0.2), value: favoriteColor)

                        HStack(spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title3)
                            Text("当前选择：\(favoriteColorInfo.name)")
                                .font(.headline)
                                .fontWeight(.semibold)
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(
                            Capsule()
                                .fill(Color.white.opacity(0.25))
                                .background(
                                    Capsule()
                                        .fill(.ultraThinMaterial)
                                )
                        )
                        .overlay(
                            Capsule()
                                .stroke(Color.white.opacity(0.4), lineWidth: 1.5)
                        )

                        HStack {
                            Image(systemName: "number")
                                .font(.caption)
                            Text("Value: \(favoriteColor)")
                                .font(.subheadline)
                        }
                        .foregroundStyle(.white.opacity(0.9))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        favoriteColorInfo.color.opacity(0.9),
                                        favoriteColorInfo.color.opacity(0.6),
                                        favoriteColorInfo.color.opacity(0.4),
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .animation(.easeInOut(duration: 0.3), value: favoriteColor)
                    )
                    .shadow(
                        color: favoriteColorInfo.color.opacity(0.4),
                        radius: 15,
                        x: 0,
                        y: 8
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.3),
                                        Color.white.opacity(0.1)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    StateDemo2View()
}
