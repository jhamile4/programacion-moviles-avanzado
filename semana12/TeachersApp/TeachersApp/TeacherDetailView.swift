//
//  TeacherDetailView.swift
//  TeachersApp
//
//  Created by Tecsup on 1/06/26.
//

import SwiftUI
import SwiftData

struct TeacherDetailView: View {
    @Bindable var teacher: Teacher  // 👈 Permite editar los campos
    @Environment(\.modelContext) private var modelContext  // 👈 Contexto para guardar cambios
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Form {
            Section(header: Text("PERSONAL INFORMATION")) {
                TextField("First Name", text: $teacher.firstName)
                TextField("Last Name", text: $teacher.lastName)
                TextField("Email", text: $teacher.email)
                    .keyboardType(.emailAddress)
                TextField("Phone", text: $teacher.phone)
                    .keyboardType(.phonePad)
                DatePicker("Date of Birth", selection: $teacher.dateOfBirth, displayedComponents: .date)
            }

            Section(header: Text("PROFESSIONAL INFORMATION")) {
                TextField("Position", text: $teacher.position)
                DatePicker("Hire Date", selection: $teacher.hireDate, displayedComponents: .date)
                Toggle("Active", isOn: $teacher.isActive)
            }
        }
        .navigationTitle("Teacher Details")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {  // 👈 Cambiamos "Done" a "Save" para mayor claridad
                    // Los cambios ya se guardan automáticamente con @Bindable y modelContext
                    // No necesitamos hacer nada más aquí porque @Bindable ya actualiza el modelo
                    dismiss()
                }
            }
        }
    }
}
