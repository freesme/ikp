# 视图布局

Stack
VStack
HStack
ZStack

使用【对齐和间距】自定义堆栈布局
    XStack init(alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil ...)
    spacing
    alignment
    

frame

padding

GeomtryReader

ignoresSafeArea() 将内容放置在安全区之外

layoutPriority() 控制布局优先级

```swift
VStack {
    Text("First Label")
    Spacer().frame(height: 50) // Spacer 制作精确大小的间隔物
    Text("Second Label")
}

// 指定与布局方向无关的间隔符大小,图有时可能位于 `HStack` 或 `VStack` 中，并且希望间隔符添加 `50` 个点而不管其方向如何。
// 在这种情况下，应使用 `minLength` 初始化程序
VStack {
    Text("First Label")
    Spacer(minLength: 50)
    Text("Second Label")
}

```

