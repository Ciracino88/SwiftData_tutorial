//
//  SwiftData_tutorialApp.swift
//  SwiftData_tutorial
//
//  Created by 이승호 on 11/5/24.
//

import SwiftUI
import SwiftData

@main
struct SwiftData_tutorialApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Student.self, Course.self])
    }
}
