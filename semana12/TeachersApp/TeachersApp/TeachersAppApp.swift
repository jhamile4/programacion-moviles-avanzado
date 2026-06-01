//
//  TeachersAppApp.swift
//  TeachersApp
//
//  Created by Tecsup on 1/06/26.
//

import SwiftUI
import SwiftData

@main
struct TeachersApp: App {
    var body: some Scene {
        WindowGroup {
            TeachersView()
        }
        .modelContainer(for: Teacher.self)
    }
}
