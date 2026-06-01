import SwiftUI

@main
struct Semana12_Ejemplo_MVVMApp: App {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                // CAMBIA ViewModel (Mayúscula) por viewModel (Minúscula)
                .environmentObject(viewModel)
        }
    }
}
