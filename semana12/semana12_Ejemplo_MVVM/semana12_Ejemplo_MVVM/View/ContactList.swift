import SwiftUI

struct ContactList: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            // Se agrega ", id: \.name" para cumplir con lo que pide SwiftUI sin alterar la guía
            List(viewModel.model.contacts, id: \.name) { contact in
                VStack(alignment: .leading, spacing: 6) {
                    Text(contact.name) // En minúscula
                        .font(.headline)
                        .foregroundColor(.blue) // Nombre en azul
                    Text(contact.email) // En minúscula
                        .font(.subheadline)
                        .foregroundColor(.gray) // Email en gris
                    Text(contact.phone) // En minúscula
                        .font(.subheadline)
                        .foregroundColor(.green) // Teléfono en verde
                }
                .padding(.vertical, 8)
            }
            .navigationTitle(" Lista de Contactos")
        }
    }
}

#Preview {
    ContactList()
        .environmentObject(ViewModel())
}
