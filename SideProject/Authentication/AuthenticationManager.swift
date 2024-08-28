//
//  AuthenticationManager.swift
//  SideProject
//
//  Created by 곽현우 on 8/27/24.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel{
    let uid: String
    let email: String?
    let photoUrl : String?
    
    init (user: User){
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    private init(){}
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let User = Auth.auth().currentUser else{
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: User)
    }
    
    //async throw를 통해 서버로 전달
    func createUser(email: String, password: String) async throws{
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let result = AuthDataResultModel(user: authDataResult.user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
