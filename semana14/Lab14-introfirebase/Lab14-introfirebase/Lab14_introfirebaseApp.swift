//
//  Lab14_introfirebaseApp.swift
//  Lab14-introfirebase
//
//  Created by Tecsup on 15/06/26.
//

import SwiftUI
import FirebaseCore

@main
struct Lab14_introfirebaseApp: App {
    init () {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
