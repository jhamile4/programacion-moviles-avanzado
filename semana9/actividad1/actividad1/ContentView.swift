//
//  ContentView.swift
//  actividad1
//
//  Created by Tecsup on 11/05/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CTSView()
                .tabItem {
                    Label("Calcular CTS", systemImage: "dollarsign.circle")
                }

            InstructorView()
                .tabItem {
                    Label("Pagos Instructor", systemImage: "pencil.and ApplePencil.circle")
                }
        }
    }
}
#Preview {
    ContentView()
}
