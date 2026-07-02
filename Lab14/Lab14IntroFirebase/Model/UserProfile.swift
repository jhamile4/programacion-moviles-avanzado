import Foundation

struct UserProfile: Codable {
    let email: String
    var displayName: String  // Este actuará como el Nombre
    var lastName: String     // NUEVO CAMPO: Apellido
    var messageCount: Int
    
    init(email: String, displayName: String, lastName: String) {
        self.email = email
        self.displayName = displayName
        self.lastName = lastName  // Inicializamos el apellido
        self.messageCount = 0
    }
}
