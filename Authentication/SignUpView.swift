//
//  SignUpView.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 03/06/25.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        VStack(spacing: 24) {
            Text("📝 Crear cuenta")
                .font(.largeTitle)
                .bold()

            TextField("Correo electrónico", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

            SecureField("Contraseña", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

            Button(action: {
                viewModel.register()
            }) {
                Text("Registrarse")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(12)
            }.alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
            }

            Button("¿Ya tienes cuenta? Inicia sesión") {
                viewModel.route = .home
            }
            .font(.footnote)
        }
        .padding()
    }
}

