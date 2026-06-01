//  Created by Juan Leon - Jame Gómez
//

import SwiftUI

// Vista principal que muestra la lista de contactos
struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        
        VStack {
            ContactList() // Vista principal
            
        }
    }
}
#Preview {
    ContentView()
        .environmentObject(ViewModel())
}
