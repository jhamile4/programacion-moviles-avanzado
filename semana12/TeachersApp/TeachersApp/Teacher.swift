//
//  Teacher.swift
//  TeachersApp
//
//  Created by Tecsup on 1/06/26.
//

import Foundation
import SwiftData

@Model
final class Teacher {
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var dateOfBirth: Date
    var position: String
    var hireDate: Date
    var isActive: Bool

    init(firstName: String,
         lastName: String,
         email: String,
         phone: String,
         dateOfBirth: Date,
         position: String,
         hireDate: Date,
         isActive: Bool) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.dateOfBirth = dateOfBirth
        self.position = position
        self.hireDate = hireDate
        self.isActive = isActive
    }
}

