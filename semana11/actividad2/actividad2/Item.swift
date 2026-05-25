//
//  Item.swift
//  actividad2
//
//  Created by Tecsup on 25/05/26.
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
