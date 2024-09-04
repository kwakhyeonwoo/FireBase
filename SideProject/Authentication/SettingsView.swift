//
//  SettingsView.swift
//  SideProject
//
//  Created by 곽현우 on 8/28/24.
//

import SwiftUI

@MainActor
final class SettingsViewModel : ObservableObject{
    
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updateEmail() async throws {
        let email = "hello123@gmail.com"
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func updatePassword() async throws {
        let password = "hello123!"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView:  Bool
    var body: some View {
        List{
            Button("Log out"){
                Task{
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch{
                        print(error)
                    }
                }
            }
            emailSection
        }
        .navigationTitle("Setting")
    }
}

#Preview {
    SettingsView(showSignInView: .constant(true))
}

extension SettingsView {
    private var emailSection: some View{
        Section{
            Button("Reset Password"){
                Task{
                    do {
                        try await viewModel.resetPassword()
                        print("Password Reset")
                    } catch{
                        print(error)
                    }
                }
            }
            
            Button("Update Password"){
                Task{
                    do {
                        try await viewModel.updatePassword()
                        print("Password Update")
                    } catch{
                        print(error)
                    }
                }
            }
            
            Button("Update email"){
                Task{
                    do {
                        try await viewModel.updateEmail()
                        print("Email Update")
                    } catch{
                        print(error)
                    }
                }
            }
        } header: {
            Text("Email functions")
        }
    }
}
