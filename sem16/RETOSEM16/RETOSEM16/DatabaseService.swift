import Foundation
import FirebaseFirestore
import Combine
import AVFoundation // <-- Framework oficial de Apple para el manejo de voz

// Modelo de Docente para Firestore
struct Docente: Identifiable, Codable {
    var id: String
    var nombre: String
    var curso: String
    var email: String
    var horario: String
}

// Modelo para los mensajes de la interfaz de usuario
struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

class DatabaseService: ObservableObject {
    private let db = Firestore.firestore()
    @Published var docentes: [Docente] = []
    @Published var chatMessages: [ChatMessage] = [
        ChatMessage(text: "¡Hola! Conectado exitosamente al agente Tecsup/schedule. ¿Qué docente o curso deseas consultar hoy?", isUser: false)
    ]
    
    // Sintetizador de voz de Apple
    private let sintetizadorVoz = AVSpeechSynthesizer()
    
    // --- LÓGICA DE FIRESTORE (CRUD) ---
    
    func fetchDocentes() {
        db.collection("docentes").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else { return }
            DispatchQueue.main.async {
                self.docentes = documents.compactMap { doc -> Docente? in
                    try? doc.data(as: Docente.self)
                }
            }
        }
    }
    
    func saveDocente(docente: Docente) {
        try? db.collection("docentes").document(docente.id).setData(from: docente)
    }
    
    func deleteDocente(id: String) {
        db.collection("docentes").document(id).delete()
    }
    
    // --- CONEXIÓN DIRECTA CON EL AGENTE ESPECIALIZADO DE TECSUP ---
    
    func preguntarIA(textoUsuario: String) {
        // Detener cualquier lectura previa si el usuario vuelve a preguntar rápido
        if sintetizadorVoz.isSpeaking {
            sintetizadorVoz.stopSpeaking(at: .immediate)
        }
        
        // 1. Mostrar el mensaje del usuario de inmediato
        chatMessages.append(ChatMessage(text: textoUsuario, isUser: true))
        
        // 2. Preparar la petición HTTP al servidor de Tecsup
        guard let url = URL(string: "http://192.168.17.11:3000/api/chat/completions") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // !!! REEMPLAZA ESTO CON TU TOKEN DE OPENWEBUI !!!
        let tokenTecsup = "sk-d3c91a1ca6374da4ad53f97c035ea3d3"
        
        request.setValue("Bearer \(tokenTecsup)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 3. Enviamos la consulta directamente al agente experto: Tecsup/schedule
        let mensajeUsuario = IAMessage(role: "user", content: textoUsuario)
        
        let payload = IARequest(
            model: "Tecsup/schedule",
            messages: [mensajeUsuario],
            stream: false
        )
        
        guard let jsonData = try? JSONEncoder().encode(payload) else { return }
        request.httpBody = jsonData
        
        // 4. Ejecutar la petición en la red local
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    let msgError = " Error de red: \(error.localizedDescription)"
                    self.chatMessages.append(ChatMessage(text: msgError, isUser: false))
                    self.reproducirTextoEnVoz(msgError) // Hablar el error
                }
                return
            }
            
            guard let data = data else { return }
            
            // Decodificar la respuesta directa del agente experto
            if let respuestaDecodificada = try? JSONDecoder().decode(IAResponse.self, from: data),
               let textoRespuesta = respuestaDecodificada.choices.first?.message.content {
                DispatchQueue.main.async {
                    self.chatMessages.append(ChatMessage(text: textoRespuesta, isUser: false))
                    
                    // ¡AQUÍ ACTIVAMOS LA VOZ! Le pasamos el texto que devolvió Tecsup/schedule
                    self.reproducirTextoEnVoz(textoRespuesta)
                }
            } else {
                DispatchQueue.main.async {
                    let msgFallo = "🤖 Error: No se pudo interpretar la respuesta del agente."
                    self.chatMessages.append(ChatMessage(text: msgFallo, isUser: false))
                    self.reproducirTextoEnVoz(msgFallo)
                }
            }
        }.resume()
    }
    
    // --- FUNCIÓN AUXILIAR DE TEXT-TO-SPEECH (NATIVA) ---
    private func reproducirTextoEnVoz(_ texto: String) {
        let enunciado = AVSpeechUtterance(string: texto)
        
        // Configuramos el idioma local (Español)
        enunciado.voice = AVSpeechSynthesisVoice(language: "es-ES")
        
        // Velocidad de lectura (0.5 es un ritmo natural y calmado)
        enunciado.rate = 0.5
        
        // Tono de voz estándar
        enunciado.pitchMultiplier = 1.0
        
        // Ordenar al iPhone que hable
        sintetizadorVoz.speak(enunciado)
    }
}
