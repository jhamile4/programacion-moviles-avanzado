//
//  CustomAIService.swift
//  Lab-Api-activ1
//
//  Created by Tecsup on 8/06/26.
//

import Foundation

struct AIRequest: Codable {
    let model: String
    let messages: [AIMessage]
    let stream: Bool
}

struct AIMessage: Codable {
    let role: String
    let content: String
}

struct AIResponse: Codable {
    let choices: [AIChoice]
}

struct AIChoice: Codable {
    let message: AIMessage
}

class CustomAIService {
    // ⚠️ RECUERDA VOLVER A PEGAR TU TOKEN AQUÍ
    private let apiKey = "sk-d3c91a1ca6374da4ad53f97c035ea3d3"
    private let urlString = "http://192.168.17.11:3000/api/chat/completions"
    private let modelName = "google/gemma-4-26B-A4B-it"
    
    func enviarPregunta(texto: String) async -> String {
        guard let url = URL(string: urlString) else { return "Error de URL." }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let cuerpoJSON = AIRequest(model: modelName, messages: [AIMessage(role: "user", content: texto)], stream: false)
        do {
            request.httpBody = try JSONEncoder().encode(cuerpoJSON)
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                return "Error del servidor local: Código \(httpResponse.statusCode)."
            }
            let resultado = try JSONDecoder().decode(AIResponse.self, from: data)
            return resultado.choices.first?.message.content ?? "Sin respuesta."
        } catch {
            return "Error de conexión: \(error.localizedDescription)"
        }
    }
}
