//
//  Item.swift
//  semana12_Ejemplo_MVVM
//
//  Created by Tecsup on 1/06/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
