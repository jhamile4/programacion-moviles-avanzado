//
//  ContentView.swift
//  sem9-actividad
//
//  Created by Tecsup on 18/05/26.
//
import SwiftUI

import SwiftUI

// Vista principal en SwiftUI - Tecsup
struct ContentView: View {
    var body: some View {
        VStack {
            // Texto superior en SwiftUI
            Text("Vista SwiftUI arriba 👇")
                .font(.title2)
                .padding()
            
            // Aquí insertamos nuestro UIViewController desde UIKit
            MiViewControllerRepresentable()
                .frame(height: 300) // Altura fija para mostrar el controlador
            
            // Texto inferior en SwiftUI
            Text("Vista SwiftUI abajo 👆")
                .font(.title2)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
