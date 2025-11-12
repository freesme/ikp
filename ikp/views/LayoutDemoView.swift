//
//  LayoutDemoView.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/10.
//

import SwiftUI

struct LayoutDemoView: View {
    var body: some View {
        // 默认情况下，SwiftUI 的视图仅占用所需的空间
        //        Button {
        //            print("Button tapped")
        //        } label: {
        //            Text("Welcome")
        //                // 使用frame获得想要的空间大小
        //                .frame(minWidth: 0, maxWidth: 200, minHeight: 0, maxHeight: 200)
        //                .font(.largeTitle)
        //        }
        //
        //        Text("Please log in")
        //        // 最大宽度最大高度
        //            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        //            .font(.largeTitle)
        //            .foregroundColor(.white)
        //            .background(Color.red)
        //            .ignoresSafeArea()
        VStack {
            Text("SwiftUI")
                .padding()
            Text("rocks")
            Text("SwiftUI2")
                .padding(.bottom)

            Text("SWIFT-UI")
                .padding(100)
            Text("SwiftUI")
                .padding(.bottom, 100)
        }
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Text("Left")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    // GeometryReader 提供相对大小
                    .frame(width: geometry.size.width * 0.33)
                    .background(Color.yellow)
                Text("Right")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .frame(width: geometry.size.width * 0.67)
                    .background(Color.orange)
            }
        }
        .frame(height: 50)
        
        Text("Hello World")
            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
            .background(Color.red)
            .ignoresSafeArea()
        
        

    }
}

#Preview {
    LayoutDemoView()
}
