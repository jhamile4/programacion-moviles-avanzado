//
//  UserFormView.swift
//  Lab-Api-activ1
//
//  Created by Tecsup on 8/06/26.
//

import SwiftUI

struct UserFormView: View {
    @ObservedObject var viewModel: UserViewModel
    var editingUser: User?
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var username: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Información")) {
                    TextField("Nombre", text: $name)
                    TextField("Nombre de usuario", text: $username)
                    TextField("Correo", text: $email).keyboardType(.emailAddress).autocapitalization(.none)
                }
            }
            .navigationTitle(editingUser == nil ? "Agregar Usuario" : "Editar Usuario")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { Button("Cancelar") { dismiss() } }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        Task {
                            if let user = editingUser {
                                await viewModel.updateUser(user: User(id: user.id, name: name, username: username, email: email))
                            } else {
                                await viewModel.addUser(user: User(id: 0, name: name, username: username, email: email))
                            }
                            dismiss()
                        }
                    }.disabled(name.isEmpty || email.isEmpty)
                }
            }
            .onAppear {
                if let user = editingUser {
                    name = user.name
                    username = user.username
                    email = user.email
                }
            }
        }
    }
}
