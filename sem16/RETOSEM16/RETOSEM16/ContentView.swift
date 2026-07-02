//
//  ContentView.swift
//  RETOSEM16
//
//  Created by Tecsup on 2/07/26.

import SwiftUI

struct ContentView: View {
    @State private var isAuthenticated = false
    
    var body: some View {
        if isAuthenticated {
            MainTabView(isAuthenticated: $isAuthenticated)
        } else {
            LoginView(isAuthenticated: $isAuthenticated)
        }
    }
}
