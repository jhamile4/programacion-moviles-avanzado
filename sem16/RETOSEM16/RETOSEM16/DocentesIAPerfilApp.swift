//
//  DocentesIAPerfilApp.swift
//  RETOSEM16
//
//  Created by Tecsup on 2/07/26.
//

import SwiftUI
import FirebaseCore

@main
struct DocentesIAPerfilApp: App {
    
    init() {
        // Inicializamos Firebase de forma segura
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            // Forzamos al sistema de Apple a renderizar tu SwiftUI de inmediato
            ContentView()
                .onAppear {
                    if let window = UIApplication.shared.windows.first {
                        window.rootViewController = UIHostingController(rootView: ContentView())
                        window.makeKeyAndVisible()
                    }
                }
        }
    }
}
