//
//  AuthCoordinatorView.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 03/06/25.
//

import Foundation
import SwiftUI

struct AuthCoordinatorView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if loginViewModel.isAuthenticated {
                    LaunchListView()
                } else {
                    LoginView(viewModel: loginViewModel)
                }
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .signUp:
                    SignUpView(viewModel: loginViewModel)

                case .forgotPassword:
                    ForgotPasswordView(viewModel: loginViewModel)

                case .home:
                    LaunchListView()

                default:
                    EmptyView()
                }
            }
        }
        .onChange(of: loginViewModel.route) { newRoute in
            if let newRoute = newRoute {
                path.append(newRoute)
                loginViewModel.route = nil
            }
        }
    }
}
