//
//  UserViewModel.swift
//  Lab-Api-activ1
//
//  Created by Tecsup on 8/06/26.
//

import Foundation
import Combine

@MainActor
class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var filteredUsers: [User] = []
    @Published var searchText: String = "" {
        didSet { filterUsers(with: searchText) }
    }
    
    let urlString = "https://jsonplaceholder.typicode.com/users"
    
    func fetchUsers() async {
        guard let url = URL(string: urlString) else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedUsers = try JSONDecoder().decode([User].self, from: data)
            self.users = decodedUsers
            self.filteredUsers = decodedUsers
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func filterUsers(with text: String) {
        if text.isEmpty {
            filteredUsers = users
        } else {
            filteredUsers = users.filter {
                $0.name.lowercased().contains(text.lowercased()) ||
                $0.email.lowercased().contains(text.lowercased())
            }
        }
    }
    
    func addUser(user: User) async {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonData = try JSONEncoder().encode(user)
            request.httpBody = jsonData
            let (data, _) = try await URLSession.shared.data(for: request)
            var newUser = try JSONDecoder().decode(User.self, from: data)
            if newUser.id == 11 || newUser.id == 101 {
                newUser.id = (users.map { $0.id }.max() ?? 0) + 1
            }
            self.users.append(newUser)
            self.filterUsers(with: self.searchText)
        } catch {
            print("Error al agregar: \(error.localizedDescription)")
        }
    }
    
    func updateUser(user: User) async {
        guard let url = URL(string: "\(urlString)/\(user.id)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonData = try JSONEncoder().encode(user)
            request.httpBody = jsonData
            let (data, _) = try await URLSession.shared.data(for: request)
            let updatedUser = try JSONDecoder().decode(User.self, from: data)
            if let index = self.users.firstIndex(where: { $0.id == user.id }) {
                self.users[index] = updatedUser
                self.filterUsers(with: self.searchText)
            }
        } catch {
            print("Error al actualizar: \(error.localizedDescription)")
        }
    }
    
    func deleteUser(at offsets: IndexSet) async {
        for index in offsets {
            let user = filteredUsers[index]
            guard let url = URL(string: "\(urlString)/\(user.id)") else { continue }
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            do {
                let (_, response) = try await URLSession.shared.data(for: request)
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    self.users.removeAll(where: { $0.id == user.id })
                    self.filterUsers(with: self.searchText)
                }
            } catch {
                print("Error al eliminar: \(error.localizedDescription)")
            }
        }
    }
}
