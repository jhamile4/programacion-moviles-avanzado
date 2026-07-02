import SwiftUI

struct UserProfileView: View {
    @StateObject private var profileService = UserProfileService()
    @State private var displayName = ""
    @State private var lastName = "" // 👈 NUEVO: Estado para capturar el apellido
    @State private var showingNameInput = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("My Profile")
                .font(.title)
                .fontWeight(.bold)
            
            // Si el usuario ya existe en Firestore
            if let user = self.profileService.currentUser {
                VStack(spacing: 15) {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 80, height: 80)
                        .overlay(
                            Text(user.displayName.prefix(1).uppercased())
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        )
                    
                    // 👈 MODIFICADO: Muestra Nombre y Apellido juntos
                    Text("\(user.displayName) \(user.lastName)")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(user.email)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    HStack(spacing: 30) {
                        VStack {
                            Text("\(user.messageCount)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            Text("Messages")
                                .font(.caption)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    
                    Button("Change Name / Last Name") {
                        displayName = user.displayName
                        lastName = user.lastName // 👈 Carga el apellido actual
                        showingNameInput = true
                    }
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
            } else {
                // Si aún no se ha creado el perfil
                VStack(spacing: 15) {
                    Text("No profile found")
                        .font(.headline)
                    
                    Text("Create your profile to get started!")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Button("Create Profile") {
                        showingNameInput = true
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            profileService.loadUser()
        }
        // 👈 MODIFICADO: Alerta con dos TextFields para Nombre y Apellido
        .alert("Enter Your Information", isPresented: $showingNameInput) {
            TextField("First Name", text: $displayName)
            TextField("Last Name", text: $lastName) // 👈 Campo para el Apellido
            
            Button("Save") {
                if !displayName.isEmpty && !lastName.isEmpty {
                    // Envia ambos datos al servicio
                    profileService.saveUser(displayName: displayName, lastName: lastName)
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Please enter your first and last name")
        }
    }
}

#Preview {
    UserProfileView()
}
