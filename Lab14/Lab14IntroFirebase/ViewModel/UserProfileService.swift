import Foundation
import FirebaseFirestore
import FirebaseAuth
import Combine // 👈 ¡ESTA IMPORTACIÓN CORRIGE TODOS LOS ERRORES!

class UserProfileService: ObservableObject {
    
    @Published var currentUser: UserProfile?
    private let db = Firestore.firestore()
    
    // Save user profile to Firestore
    // Modifica la función saveUser para recibir el apellido
    func saveUser(displayName: String, lastName: String) {
        guard let firebaseUser = Auth.auth().currentUser,
              let email = firebaseUser.email else { return }
        
        // 👈Pasamos el apellido al inicializador del modelo
        let user = UserProfile(email: email, displayName: displayName, lastName: lastName)
        
        do {
            try db.collection("users").document(firebaseUser.uid).setData(from: user)
            DispatchQueue.main.async {
                self.currentUser = user
            }
            print("User saved successfully con apellido!")
        } catch {
            print("Error saving user: \(error)")
        }
    }
    
    // Load user profile from Firestore
    func loadUser() {
        guard let firebaseUser = Auth.auth().currentUser else { return }
        
        db.collection("users").document(firebaseUser.uid).getDocument { document, error in
            if let error = error {
                print("Error loading user: \(error)")
                return
            }
            
            if let document = document, document.exists {
                do {
                    let decodedUser = try document.data(as: UserProfile.self)
                    DispatchQueue.main.async {
                        self.currentUser = decodedUser
                    }
                    print("User loaded successfully!")
                } catch {
                    print("Error decoding user: \(error)")
                }
            } else {
                print("User document does not exist")
            }
        }
    }
    
    // Update message count
    func addMessage() {
        guard let firebaseUser = Auth.auth().currentUser else { return }
        
        db.collection("users").document(firebaseUser.uid).updateData([
            "messageCount": FieldValue.increment(Int64(1))
        ]) { error in
            if let error = error {
                print("Error incrementing messages in Firestore: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.currentUser?.messageCount += 1
                }
            }
        }
    }
}
