import Foundation
import SwiftUI

class Model{
    var contacts: [Contact]
    
    init() {
        self.contacts = [
            Contact(name: "Juan Leon", phone: "909089098", email: "xxxx@gmail.com"),
            Contact(name: "Jaime Gomez", phone: "909089087", email: "xxxx@gmail.com"),
            Contact(name: "Jaime Farfan", phone: "909989098", email: "xxxx@gmail.com"),
            Contact(name: "Silvia Montoya", phone: "901239098", email: "xxxx@gmail.com"),
            Contact(name: "Elliot Garamendi", phone: "956089098", email: "xxxx@gmail.com"),
        ]
    }
}
struct Contact: Identifiable {
    let id = UUID()
    let name: String
    let phone: String
    let email: String
}
