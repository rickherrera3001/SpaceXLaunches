//
//  LoginView.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 03/06/25.
//

//import SwiftUI
//
//struct LoginView: View {
//    @StateObject var viewModel = LoginViewModel()
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 32) {
//                Text("🚀 SpaceX Login")
//                    .font(.largeTitle)
//                    .bold()
//                
//                TextField("Email", text: $viewModel.email)
//                    .keyboardType(.emailAddress)
//                    .textContentType(.emailAddress)
//                    .autocapitalization(.none)
//                    .padding()
//                    .background(Color.gray.opacity(0.1))
//                    .cornerRadius(12)
//                
//                SecureField("Password", text: $viewModel.password)
//                    .padding()
//                    .background(Color.gray.opacity(0.1))
//                    .cornerRadius(12)
//                
//                Button("Login") {
//                    viewModel.login()
//                }
//                .frame(maxWidth: .infinity)
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(12)
//                
//                HStack {
//                    NavigationLink(destination: ForgotPasswordView()) {
//                        Text("Forgot your password")
//                    }
//                    .font(.footnote)
//                    
//                    Spacer()
//                    
//                    NavigationLink(destination: SignUpView()) {
//                        Text("Create Account")
//                    }
//                    .font(.footnote)
//                }
//                
//                Spacer()
//            }
//            .padding()
//            .alert("Error", isPresented: .constant(!viewModel.errorMessage.isEmpty), actions: {
//                Button("OK", role: .cancel) {
//                    viewModel.errorMessage = ""
//                }
//            }, message: {
//                Text(viewModel.errorMessage)
//            })
//        }
//    }
//}

//
//  LoginView.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 03/06/25.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        VStack(spacing: 32) {
            Text("🚀 SpaceX Login")
                .font(.largeTitle)
                .bold()

            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

            Button(action: {
                viewModel.login()
            }) {
                Text("Iniciar sesión")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
            }

            VStack {
                Button("¿Olvidaste tu contraseña?") {
                    viewModel.route = .forgotPassword
                }
                .font(.footnote)

                Button("¿No tienes cuenta? Regístrate") {
                    viewModel.route = .signUp
                }
                .font(.footnote)
            }
        }
        .padding()
    }
}

