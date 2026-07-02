//
//  MainTabView.swift
//  RETOSEM16
//
//  Created by Tecsup on 2/07/26.
//

import SwiftUI
import FirebaseAuth

struct MainTabView: View {
    @Binding var isAuthenticated: Bool
    @StateObject private var service = DatabaseService()
    
    var body: some View {
        TabView {
            DocentesCRUDView(service: service)
                .tabItem {
                    Label("Docentes", systemImage: "person.2.crop.square.stack.fill")
                }
            
            ChatbotView(service: service)
                .tabItem {
                    Label("Chatbot IA", systemImage: "bubble.left.and.bubble.right.fill")
                }
            
            // Sección de Perfil
            VStack(spacing: 25) {
                Image(systemName: "person.crop.circle.badge.checkmark")
                    .font(.system(size: 80))
                    .foregroundColor(.green)
                
                Text("Sesión Iniciada con Éxito")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(Auth.auth().currentUser?.email ?? "correo@universidad.edu.pe")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                Button(action: {
                    try? Auth.auth().signOut()
                    isAuthenticated = false
                }) {
                    Text("Cerrar Sesión")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
            }
            .tabItem {
                Label("Mi Perfil", systemImage: "person.text.rectangle.fill")
            }
        }
        .onAppear {
            service.fetchDocentes()
        }
    }
}
