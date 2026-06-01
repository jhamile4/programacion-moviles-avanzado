//
//  AddTeacherView.swift
//  TeachersApp
//
//  Created by Tecsup on 1/06/26.
//

import SwiftUI
import SwiftData

struct AddTeacherView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var dateOfBirth = Date()
    @State private var position = ""
    @State private var hireDate = Date()
    @State private var isActive = true

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("PERSONAL INFORMATION")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                    TextField("Phone", text: $phone)
                        .keyboardType(.phonePad)
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                }

                Section(header: Text("PROFESSIONAL INFORMATION")) {
                    TextField("Position", text: $position)
                    DatePicker("Hire Date", selection: $hireDate, displayedComponents: .date)
                    Toggle("Active", isOn: $isActive)
                }
            }
            .navigationTitle("Add Teacher")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newTeacher = Teacher(
                            firstName: firstName,
                            lastName: lastName,
                            email: email,
                            phone: phone,
                            dateOfBirth: dateOfBirth,
                            position: position,
                            hireDate: hireDate,
                            isActive: isActive
                        )
                        modelContext.insert(newTeacher)
                        dismiss()
                    }
                }
            }
        }
    }
}
