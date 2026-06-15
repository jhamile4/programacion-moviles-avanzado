//
//  AuthView.swift
//  Lab14-introfirebase
//
//  Created by Tecsup on 15/06/26.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

struct AuthView: View {
    @State private var isSignedIn = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var authStateListener: AuthStateDidChangeListenerHandle?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Lab 14: Firebase")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)
                
                Spacer()
                
                if isSignedIn {
                    MessagesView()
                } else {
                    VStack(spacing: 20) {
                        Text("Bienvenido a la Aplicación")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        // Botón de Google
                        Button(action: {
                            signInWithGoogle()
                        }) {
                            HStack {
                                Image(systemName: "g.circle.fill")
                                    .font(.title2)
                                Text("Sign In with Google")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(PrimaryButtonStyle()) // Ahora sí lo encontrará
                        
                    }
                    .padding(.horizontal, 30)
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
        .alert("Message", isPresented: $showAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
        .onAppear {
            checkAuthState()
        }
    }
    
    // MARK: - Google Sign In Function
    
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
            if let error = error {
                alertMessage = "Google login failed: \(error.localizedDescription)"
                showAlert = true
                return
            }
            
            guard let user = signInResult?.user,
                  let idToken = user.idToken?.tokenString else { return }
            
            let accessToken = user.accessToken.tokenString
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    alertMessage = "Firebase login failed: \(error.localizedDescription)"
                    showAlert = true
                } else {
                    isSignedIn = true
                    alertMessage = "Google Sign In successful!"
                    showAlert = true
                }
            }
        }
    }
    
    func checkAuthState() {
        authStateListener = Auth.auth().addStateDidChangeListener { auth, user in
            DispatchQueue.main.async {
                self.isSignedIn = user != nil
            }
        }
    }
}

// MARK: - Button Styles (ESTO ES LO QUE FALTABA)

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.blue)
            .padding()
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct SignOutButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(Color.red)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
