//
//  ForgotPasswordView.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 03/06/25.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        VStack(spacing: 24) {
            Text("Recover password 🔒")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            
            TextField("Email", text: $viewModel.forgotPasswordEmail)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)

            Button("Send recovery link") {
                viewModel.forgotPassword()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(12)

            if !viewModel.forgotPasswordErrorMessage.isEmpty {
                Text(viewModel.forgotPasswordErrorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            if viewModel.isForgotPasswordSuccess {
                Text("✅ Check your email to reset your password.")
                    .foregroundColor(.green)
                    .font(.footnote)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Forgot your password?")
        .navigationBarTitleDisplayMode(.inline)
    }
}
