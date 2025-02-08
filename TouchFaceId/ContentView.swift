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
                Text("Authentication successful!")
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
                Text("Authenticate with Touch ID / Face ID")
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

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate for having access to application"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        isAuthenticated = true
                        errorMessage = ""
                    } else {
                        isAuthenticated = false
                        errorMessage = "Failed authentication"
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
