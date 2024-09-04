//
//  RootView.swift
//  SideProject
//
//  Created by 곽현우 on 8/28/24.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView : Bool = false
    
    var body: some View {
        ZStack{
            NavigationStack{
                SettingsView(showSignInView: $showSignInView)
            }
        }
        .onAppear{
            let authuser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authuser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack{
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    RootView()
}
