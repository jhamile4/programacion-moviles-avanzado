//
//  DocentesCRUDView.swift
//  RETOSEM16
//
//  Created by Tecsup on 2/07/26.
//

import SwiftUI

struct DocentesCRUDView: View {
    @ObservedObject var service: DatabaseService
    @State private var abrirModal = false
    
    // Saber si estamos editando o creando uno nuevo
    @State private var docenteAEditar: Docente? = nil
    
    // Variables temporales del formulario
    @State private var nombre = ""
    @State private var curso = ""
    @State private var email = ""
    @State private var fechaSeleccionada = Date() // Controla el Calendario
    
    var body: some View {
        NavigationView {
            List {
                ForEach(service.docentes) { docente in
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(docente.nombre)
                                .font(.headline)
                            Text("基因 \(docente.curso)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("🗓️ Horario: \(docente.horario)")
                                .font(.caption)
                                .foregroundColor(.blue)
                                .fontWeight(.semibold)
                        }
                        
                        Spacer()
                        
                        // Botón de Editar
                        Button(action: {
                            prepararEdicion(docente: docente)
                        }) {
                            Image(systemName: "pencil.circle.fill")
                                .font(.title2)
                                .foregroundColor(.orange)
                        }
                        .buttonStyle(PlainButtonStyle()) // Evita que interfiera con la celda
                    }
                    .padding(.vertical, 4)
                }
                .onDelete(perform: eliminar)
            }
            .navigationTitle("Directorio Docente")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        docenteAEditar = nil
                        nombre = ""; curso = ""; email = ""; fechaSeleccionada = Date()
                        abrirModal.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $abrirModal) {
                NavigationView {
                    Form {
                        Section(header: Text("Datos del Docente")) {
                            TextField("Nombre Completo", text: $nombre)
                            TextField("Correo Electrónico", text: $email)
                                .keyboardType(.emailAddress)
                        }
                        
                        Section(header: Text("Asignatura")) {
                            TextField("Curso", text: $curso)
                        }
                        
                        // CALENDARIO CON FECHA Y HORA NATIVO
                        Section(header: Text("Asignar Fecha y Hora")) {
                            DatePicker("Horario:", selection: $fechaSeleccionada, displayedComponents: [.date, .hourAndMinute])
                                .datePickerStyle(GraphicalDatePickerStyle()) // Calendario visual elegante
                        }
                        
                        Button(action: {
                            guard !nombre.isEmpty && !curso.isEmpty else { return }
                            
                            // Formatear la fecha seleccionada a texto legible
                            let formatter = DateFormatter()
                            formatter.dateFormat = "dd/MM/yyyy hh:mm a"
                            let horarioTexto = formatter.string(from: fechaSeleccionada)
                            
                            // Si estamos editando usamos su mismo ID, si no, creamos uno nuevo
                            let idFinal = docenteAEditar?.id ?? UUID().uuidString
                            let nuevoDocente = Docente(id: idFinal, nombre: nombre, curso: curso, email: email, horario: horarioTexto)
                            
                            service.saveDocente(docente: nuevoDocente)
                            abrirModal = false
                        }) {
                            Text(docenteAEditar == nil ? "Registrar en Firestore" : "Guardar Cambios")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(.white)
                        }
                        .listRowBackground(docenteAEditar == nil ? Color.blue : Color.orange)
                    }
                    .navigationTitle(docenteAEditar == nil ? "Nuevo Registro" : "Editar Docente")
                    .navigationBarItems(leading: Button("Cancelar") { abrirModal = false })
                }
            }
        }
    }
    
    func prepararEdicion(docente: Docente) {
        docenteAEditar = docente
        nombre = docente.nombre
        curso = docente.curso
        email = docente.email
        
        // Intentar recuperar la fecha guardada en texto para poner el calendario en su lugar
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy hh:mm a"
        if let fechaGuardada = formatter.date(from: docente.horario) {
            fechaSeleccionada = fechaGuardada
        } else {
            fechaSeleccionada = Date()
        }
        
        abrirModal = true
    }
    
    func eliminar(at offsets: IndexSet) {
        offsets.forEach { index in
            let idDocente = service.docentes[index].id
            service.deleteDocente(id: idDocente)
        }
    }
}
