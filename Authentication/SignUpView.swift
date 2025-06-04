//
//  SignUpView.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 03/06/25.
//

//import SwiftUI
//
//struct SignUpView: View {
//    @StateObject private var viewModel = LoginViewModel()
//    
//    var body: some View {
//        VStack(spacing: 24) {
//            Text("Crear cuenta 🚀")
//                .font(.largeTitle)
//                .bold()
//            
//            TextField("Full name", text: $viewModel.name)
//                .padding()
//                .background(Color.gray.opacity(0.1))
//                .cornerRadius(10)
//            
//            TextField("Email", text: $viewModel.email)
//                .keyboardType(.emailAddress)
//                .autocapitalization(.none)
//                .textContentType(.emailAddress)
//                .padding()
//                .background(Color.gray.opacity(0.1))
//                .cornerRadius(10)
//            
//            SecureField("Password (minimum 6 characters))", text: $viewModel.password)
//                .padding()
//                .background(Color.gray.opacity(0.1))
//                .cornerRadius(10)
//            
//            Button(action: {
//                viewModel.register()
//            }) {
//                Text("Register")
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.green)
//                    .foregroundColor(.white)
//                    .cornerRadius(12)
//            }
//            
//            if !viewModel.errorMessage.isEmpty {
//                Text(viewModel.errorMessage)
//                    .foregroundColor(.red)
//                    .font(.footnote)
//            }
//            
//            Spacer()
//        }
//        .padding()
//        .navigationTitle("Register")
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationDestination(for: AppRoute.self) { route in
//            if route == .home {
//                Text("Main view of the app")
//            }
//        }
//    }
//}
//

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
            }

            Button("¿Ya tienes cuenta? Inicia sesión") {
                viewModel.route = .home
            }
            .font(.footnote)
        }
        .padding()
    }
}

