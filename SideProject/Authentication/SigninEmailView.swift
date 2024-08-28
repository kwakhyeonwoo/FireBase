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
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else{
            print("이메일과 비밀번호를 찾을 수 없습니다")
            return
        }
        
        Task{
            do{
                let returnedUserDate = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                print(returnedUserDate)
            } catch{
                print("Error: \(error)")
            }
        }
    }
    
}

struct SigninEmailView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    
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
                viewModel.signIn()
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
        SigninEmailView()
    }
}
