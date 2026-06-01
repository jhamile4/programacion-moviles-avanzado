//
//  TeachersView.swift
//  TeachersApp
//
//  Created by Tecsup on 1/06/26.
//

import SwiftUI
import SwiftData

struct TeachersView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allTeachers: [Teacher]
    @State private var searchText: String = ""
    @State private var showingAddTeacher = false

    var filteredTeachers: [Teacher] {
        if searchText.isEmpty {
            return allTeachers
        } else {
            let lowercasedSearchText = searchText.lowercased()
            return allTeachers.filter { teacher in
                "\(teacher.firstName) \(teacher.lastName)".lowercased().contains(lowercasedSearchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredTeachers) { teacher in
                    NavigationLink {
                        TeacherDetailView(teacher: teacher)  // 👈 Pasa el docente para editar
                    } label: {
                        VStack(alignment: .leading) {
                            Text("\(teacher.firstName) \(teacher.lastName)")
                                .font(.headline)
                            Text(teacher.position)
                                .font(.subheadline)
                                .foregroundStyle(.blue)
                            Text(teacher.email)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteTeachers)
            }
            .navigationTitle("Teachers")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search teachers...")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: { showingAddTeacher = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTeacher) {
                AddTeacherView()
            }
        }
    }

    private func deleteTeachers(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(filteredTeachers[index])
            }
        }
    }
}
