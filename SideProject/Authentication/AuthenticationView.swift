//
//  AuthenticationView.swift
//  SideProject
//
//  Created by 곽현우 on 8/27/24.
//

import SwiftUI

struct AuthenticationView: View {
    var body: some View {
        VStack{
            NavigationLink{
                SigninEmailView()
            } label: {
                Text("Sing in Email Address")
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
        .navigationTitle("Sing in")
    }
}

#Preview {
    NavigationStack{
        AuthenticationView()
    }

}
