//
//  LoginView.swift
//  RETOSEM16
//
//  Created by Tecsup on 2/07/26.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

struct LoginView: View {
    @Binding var isAuthenticated: Bool
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(systemName: "graduationcap.circle.fill")
                .font(.system(size: 90))
                .foregroundColor(.blue)
            
            Text("Portal de Docentes & IA")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Gestiona horarios y realiza consultas inteligentes")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            Spacer()
            
            Button(action: {
                signInWithGoogle()
            }) {
                HStack(spacing: 15) {
                    Image(systemName: "g.circle.fill")
                        .font(.title2)
                    Text("Iniciar Sesión con Google")
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(12)
                .shadow(radius: 3)
            }
            .padding(.horizontal, 30)
            
            Spacer()
        }
        .alert("Autenticación", isPresented: $showAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
    }
    
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
            if let error = error {
                alertMessage = "Error Google: \(error.localizedDescription)"
                showAlert = true
                return
            }
            
            guard let user = signInResult?.user,
                  let idToken = user.idToken?.tokenString else { return }
            
            let accessToken = user.accessToken.tokenString
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    alertMessage = "Error Firebase: \(error.localizedDescription)"
                    showAlert = true
                } else {
                    isAuthenticated = true
                }
            }
        }
    }
}
