//
//  LoginViewModel.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 03/06/25.
//

//
//  LoginViewModel.swift
//  SpaceXLaunches
//
//  Created by Ricardo Ivan Herrera Rocha on 03/06/25.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

@MainActor
class LoginViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var forgotPasswordEmail: String = ""

    @Published var errorMessage: String = ""
    @Published var forgotPasswordErrorMessage: String = ""
    @Published var isForgotPasswordSuccess = false
    @Published var isAuthenticated: Bool = false
    @Published var route: AppRoute?

    // MARK: - Init
    init() {
        checkAuthStatus()
    }

    private func checkAuthStatus() {
        if Auth.auth().currentUser != nil {
            isAuthenticated = true
            route = .home
        } else {
            isAuthenticated = false
            route = .login
        }
    }

    // MARK: - Register
    func register() {
        guard validateRegistration() else { return }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }

            guard let userId = result?.user.uid else {
                self?.errorMessage = "Failed to retrieve user ID."
                return
            }

            self?.insertUserRecord(id: userId)
            self?.route = .home
        }
    }

    private func insertUserRecord(id: String) {
        let newUser = User(id: id, name: name, email: email, joined: Date().timeIntervalSince1970)
        let db = Firestore.firestore()
        
        db.collection("users").document(id).setData(newUser.asDictionary()) { [weak self] error in
            if let error = error {
                self?.errorMessage = "Failed to insert user record: \(error.localizedDescription)"
            }
        }
    }

    // MARK: - Login
    func login() {
        guard validateLogin() else { return }

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                self?.isAuthenticated = false
                return
            }

            self?.errorMessage = ""
            self?.isAuthenticated = true
            self?.route = .home
        }
    }

    // MARK: - Forgot Password
    func forgotPassword() {
        guard validateForgotPassword() else { return }

        Auth.auth().sendPasswordReset(withEmail: forgotPasswordEmail) { [weak self] error in
            if let error = error {
                self?.forgotPasswordErrorMessage = error.localizedDescription
                self?.isForgotPasswordSuccess = false
            } else {
                self?.isForgotPasswordSuccess = true
            }
        }
    }

    // MARK: - Navigation
    func goToSignUp() {
        resetErrors()
        name = ""
        password = ""
        email = ""
        route = .signUp
    }

    func goToForgotPassword() {
        route = .forgotPassword
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
            route = .login
            resetForm()
        } catch {
            errorMessage = "No se pudo cerrar sesión: \(error.localizedDescription)"
        }
    }

    // MARK: - Validations
    private func validateRegistration() -> Bool {
        errorMessage = ""
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }

        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email."
            return false
        }

        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters long."
            return false
        }

        return true
    }

    private func validateLogin() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }

        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email."
            return false
        }

        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters long."
            return false
        }

        return true
    }

    private func validateForgotPassword() -> Bool {
        forgotPasswordErrorMessage = ""
        guard !forgotPasswordEmail.trimmingCharacters(in: .whitespaces).isEmpty else {
            forgotPasswordErrorMessage = "Please enter your email address."
            return false
        }

        guard forgotPasswordEmail.contains("@") && forgotPasswordEmail.contains(".") else {
            forgotPasswordErrorMessage = "Please enter a valid email address."
            return false
        }

        return true
    }

    // MARK: - Form Reset
    func resetErrors() {
        errorMessage = ""
        forgotPasswordErrorMessage = ""
        isForgotPasswordSuccess = false
    }

    private func resetForm() {
        email = ""
        password = ""
        name = ""
        forgotPasswordEmail = ""
        errorMessage = ""
        forgotPasswordErrorMessage = ""
        isForgotPasswordSuccess = false
    }
}
