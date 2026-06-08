//
//  ContentView.swift
//  Lab-Api-activ1
//
//  Created by Tecsup on 8/06/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var editingUser: User? = nil
    @State private var showingForm = false
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    TextField("Buscar usuario...", text: $viewModel.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.horizontal)
                    List {
                        ForEach(viewModel.filteredUsers) { user in
                            VStack(alignment: .leading) {
                                Text(user.name).font(.headline)
                                Text(user.email).font(.subheadline).foregroundColor(.gray)
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    Task {
                                        if let index = viewModel.filteredUsers.firstIndex(where: { $0.id == user.id }) {
                                            await viewModel.deleteUser(at: IndexSet(integer: index))
                                        }
                                    }
                                } label: { Label("Borrar", systemImage: "trash") }
                                
                                Button {
                                    editingUser = user
                                    showingForm = true
                                } label: { Label("Editar", systemImage: "pencil") }.tint(.blue)
                            }
                        }
                    }.listStyle(PlainListStyle())
                }
                .navigationTitle("Usuarios")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { editingUser = nil; showingForm = true }) { Image(systemName: "plus") }
                    }
                }
                .sheet(isPresented: $showingForm) { UserFormView(viewModel: viewModel, editingUser: editingUser) }
                .task { await viewModel.fetchUsers() }
            }
            .tabItem { Label("Usuarios", systemImage: "person.3.fill") }
            
            CustomAIView()
                .tabItem { Label("Asistente IA", systemImage: "brain.head_profile") }
        }
    }
}
