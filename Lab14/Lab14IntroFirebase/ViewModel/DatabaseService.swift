import Foundation
import FirebaseFirestore
import FirebaseAuth
import Combine

class DatabaseService: ObservableObject {
    
    private let db = Firestore.firestore()
    @Published var messages: [Message] = []
    
    // CORRECCIÓN: Instancia normal, sin @StateObject dentro de una clase de servicio.
    private let profileService = UserProfileService()
    
    // Add a message to database
    func addMessage(text: String) {
        guard let user = Auth.auth().currentUser else { return }
        
        let message = Message(
            id: UUID().uuidString,
            text: text,
            userEmail: user.email ?? "Unknown",
            timestamp: Date()
        )
        
        do {
            print("message \(message.userEmail)")
            try db.collection("messages").document(message.id).setData(from: message)
            
            // Incrementa el contador en la base de datos
            profileService.addMessage()
        } catch {
            print("Error adding message: \(error)")
        }
    }
    
    // Listen for real-time updates
    func startListening() {
        db.collection("messages")
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting messages: \(error)")
                    return
                }
                
                // CORRECCIÓN: Asignar al hilo principal para que la lista de SwiftUI se entere del cambio
                DispatchQueue.main.async {
                    self.messages = querySnapshot?.documents.compactMap { document in
                        try? document.data(as: Message.self)
                    } ?? []
                }
            }
    }
}

// Message data model
struct Message: Identifiable, Codable {
    let id: String
    let text: String
    let userEmail: String
    let timestamp: Date
}
