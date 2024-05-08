//
//  UserProfile.swift
//  LittleLemonRestaurant
//
//  Created by tony on 5/5/2024.
//

import SwiftUI

struct UserProfile: View {
    
    private let firstName: String = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    private let lastName: String = UserDefaults.standard.string(forKey: kLastName) ?? ""
    private let email: String = UserDefaults.standard.string(forKey: kEmail) ?? ""
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
    
        VStack {
            Text("Personal Information")
            Image(uiImage: UIImage(imageLiteralResourceName: "profile-image-placeholder"))
            
            Text(firstName)
            Text(lastName)
            Text(email)
            
            Button("Log Out") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            
            Spacer()
            
        }
        
    }
}

#Preview {
    NavigationStack {
        UserProfile()
    }
    
}
