//
//  ForgotPasswordView.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 03/06/25.
//

//import SwiftUI
//
//struct ForgotPasswordView: View {
//    @StateObject private var viewModel = LoginViewModel()
//
//    var body: some View {
//        VStack(spacing: 24) {
//            Text("Recover password 🔒")
//                .font(.largeTitle)
//                .bold()
//                .multilineTextAlignment(.center)
//            
//            TextField("Email", text: $viewModel.forgotPasswordEmail)
//                .keyboardType(.emailAddress)
//                .textContentType(.emailAddress)
//                .autocapitalization(.none)
//                .padding()
//                .background(Color.gray.opacity(0.1))
//                .cornerRadius(10)
//
//            Button("Send recovery link") {
//                viewModel.forgotPassword()
//            }
//            .frame(maxWidth: .infinity)
//            .padding()
//            .background(Color.orange)
//            .foregroundColor(.white)
//            .cornerRadius(12)
//
//            if !viewModel.forgotPasswordErrorMessage.isEmpty {
//                Text(viewModel.forgotPasswordErrorMessage)
//                    .foregroundColor(.red)
//                    .font(.footnote)
//            }
//
//            if viewModel.isForgotPasswordSuccess {
//                Text("✅ Check your email to reset your password.")
//                    .foregroundColor(.green)
//                    .font(.footnote)
//            }
//
//            Spacer()
//        }
//        .padding()
//        .navigationTitle("Forgot your password?")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}


//
//  ForgotPasswordView.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 03/06/25.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        VStack(spacing: 24) {
            Text("🔑 Recuperar contraseña")
                .font(.largeTitle)
                .bold()

            Text("Ingresa tu correo y te enviaremos un enlace para restablecer tu contraseña.")
                .font(.body)

            TextField("Correo electrónico", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

            Button(action: {
                viewModel.resetPassword()
            }) {
                Text("Enviar enlace")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(12)
            }

            Button("¿Recordaste tu contraseña? Inicia sesión") {
                viewModel.route = .home
            }
            .font(.footnote)
        }
        .padding()
    }
}
