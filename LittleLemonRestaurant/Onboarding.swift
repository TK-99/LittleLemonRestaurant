//
//  Onboarding.swift
//  LittleLemonRestaurant
//
//  Created by tony on 5/5/2024.
//

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "kIsLoggedIn"

import SwiftUI



struct Onboarding: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                        .textContentType(.emailAddress)       // !IMPORTANT FOR EMAILS
                        .disableAutocorrection(true)          // !IMPORTANT FOR EMAILS
                        .textInputAutocapitalization(.never)  // !IMPORTANT FOR EMAILS
    //                    .foregroundColor(email.isValidEmail ? .white : .red) // <- Example of a validation here
    //                    .background(email.isValidEmail ? .green : .black)    // <- Example of a validation here
        
                
                Button("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        isLoggedIn = true
                    } else {
                        
                    }
                }
                
            }
        }
        .onAppear {
            if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                isLoggedIn = true
            }
        }
        .navigationDestination(isPresented: $isLoggedIn) { 
                        Home()
                           .environment(\.managedObjectContext, viewContext)
            
        }
    }
    
}

extension String {
    
    var isValidEmail: Bool {
//        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
//        ).evaluate(with: self)
        
        NSPredicate(format: "SELF MATCHES %@", "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

        ).evaluate(with: self)
        
    }
}


#Preview {
    NavigationStack {
        Onboarding()
    }
}
