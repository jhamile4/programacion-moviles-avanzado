//
//  IAModels.swift
//  RETOSEM16
//
//  Created by Tecsup on 2/07/26.
//

import Foundation

// Lo que enviamos a la API de Tecsup
struct IARequest: Codable {
    let model: String
    let messages: [IAMessage]
    let stream: Bool
}

struct IAMessage: Codable {
    let role: String
    let content: String
}

// Lo que el servidor de Tecsup nos responde
struct IAResponse: Codable {
    let choices: [IAChoice]
}

struct IAChoice: Codable {
    let message: IAMessage
}
