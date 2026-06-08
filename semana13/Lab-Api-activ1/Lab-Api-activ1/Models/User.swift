//
//  User.swift
//  Lab-Api-activ1
//
//  Created by Tecsup on 8/06/26.
//

import Foundation

struct User: Codable, Identifiable {
    var id: Int // 'var' para que el ViewModel pueda cambiar el ID repetido de la API de prueba
    let name: String
    let username: String
    let email: String
}
