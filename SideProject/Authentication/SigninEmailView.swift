//
//  SigninEmailView.swift
//  SideProject
//
//  Created by 곽현우 on 8/27/24.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel : ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else{
            print("이메일과 비밀번호를 찾을 수 없습니다")
            return
        }
        try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else{
            print("이메일과 비밀번호를 찾을 수 없습니다")
            return
        }
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
    
}

struct SigninEmailView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack{
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                Task{
                    do {
                        try await viewModel.signUp()
                        showSignInView = false
                        return
                    } catch {
                        print(error)
                    }
                    
                    do {
                        try await viewModel.signIn()
                        showSignInView = false
                        return
                    } catch {
                       print(error)
                    }

                }
            } label: {
                Text("Sing in")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
            
        }
        .padding()
        .navigationTitle("Sign in With Email")
    }
}

#Preview {
    NavigationStack{
        SigninEmailView(showSignInView: .constant(false))
    }
}
