//
//  ChatbotView.swift
//  RETOSEM16
//
//  Created by Tecsup on 2/07/26.
//

import SwiftUI
import Combine

struct ChatbotView: View {
    @ObservedObject var service: DatabaseService
    @State private var mensajeTexto = ""
    
    var body: some View {
        VStack {
            // Header del Chatbot
            HStack {
                VStack(alignment: .leading) {
                    Text("Asistente Virtual IA")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Horarios y Cursos Institucionales")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
                Image(systemName: "bolt.shield.fill")
                    .font(.title)
                    .foregroundColor(.blue)
            }
            .padding()
            
            // Área de conversación
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(service.chatMessages) { msg in
                        HStack {
                            if msg.isUser { Spacer() }
                            
                            Text(msg.text)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .background(msg.isUser ? Color.blue : Color(.systemGray5))
                                .foregroundColor(msg.isUser ? .white : .black)
                                .cornerRadius(16)
                                .frame(maxWidth: 280, alignment: msg.isUser ? .trailing : .leading)
                            
                            if !msg.isUser { Spacer() }
                        }
                    }
                }
                .padding()
            }
            
            // Entrada inferior de texto
            HStack(spacing: 12) {
                TextField("Pregunta por un docente (ej: Carlos)...", text: $mensajeTexto)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(22)
                
                Button(action: {
                    if !mensajeTexto.isEmpty {
                        service.preguntarIA(textoUsuario: mensajeTexto)
                        mensajeTexto = ""
                    }
                }) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .padding(12)
                        .background(mensajeTexto.isEmpty ? Color.gray : Color.blue)
                        .clipShape(Circle())
                }
                .disabled(mensajeTexto.isEmpty)
            }
            .padding()
        }
    }
}
