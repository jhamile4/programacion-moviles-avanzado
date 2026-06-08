//
//  CustomAIView.swift
//  Lab-Api-activ1
//
//  Created by Tecsup on 8/06/26.
//

import SwiftUI

struct CustomAIView: View {
    @State private var query: String = ""
    @State private var responseText: String = "¡Hola! Conectado al Proyecto TD-GPT de Tecsup."
    @State private var isLoading: Bool = false
    private let aiService = CustomAIService()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    Text(responseText)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding()
                }
                if isLoading { ProgressView("Gemma procesando...") }
                HStack {
                    TextField("Escribe una pregunta...", text: $query).textFieldStyle(RoundedBorderTextFieldStyle()).disabled(isLoading)
                    Button(action: {
                        guard !query.isEmpty else { return }
                        isLoading = true
                        let p = query
                        query = ""
                        Task {
                            let r = await aiService.enviarPregunta(texto: p)
                            await MainActor.run { responseText = r; isLoading = false }
                        }
                    }) {
                        Image(systemName: "paperplane.fill").foregroundColor(.white).padding(10).background(query.isEmpty || isLoading ? Color.gray : Color.blue).clipShape(Circle())
                    }.disabled(query.isEmpty || isLoading)
                }.padding()
            }.navigationTitle("Asistente TD-GPT")
        }
    }
}
