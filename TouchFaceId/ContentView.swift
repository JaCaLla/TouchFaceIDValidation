//
//  ContentView.swift
//  TouchFaceId
//
//  Created by Javier Calatrava on 6/2/25.
//


import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var isAuthenticated = false
    @State private var errorMessage = ""

    var body: some View {
        VStack {
            if isAuthenticated {
                Text("¡Autenticación exitosa!")
                    .font(.title)
                    .foregroundColor(.green)
            } else {
                Text(errorMessage)
                    .font(.title)
                    .foregroundColor(.red)
            }

            Button(action: {
                authenticate()
            }) {
                Text("Autenticar con Touch ID / Face ID")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // Verifica si el dispositivo soporta Touch ID o Face ID
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Autentícate para acceder a la aplicación"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        isAuthenticated = true
                        errorMessage = ""
                    } else {
                        isAuthenticated = false
                        errorMessage = "Autenticación fallida"
                    }
                }
            }
        } else {
            isAuthenticated = false
            errorMessage = "Touch ID / Face ID no está disponible"
        }
    }
}

#Preview {
    ContentView()
}
