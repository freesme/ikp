//
//  ikpApp.swift
//  ikp
//
//  Created by ibuprofen on 2025/11/4.
//

import SwiftUI

@main
struct ikpApp: App {
        init() {
        UserDefaults.standard.register(defaults: [
            "name": "Taylor Swift",
            "highScore": 10
        ])
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
