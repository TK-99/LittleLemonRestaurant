//
//  Onboarding.swift
//  LittleLemonRestaurant
//
//  Created by tony on 5/5/2024.
//



import SwiftUI
import Combine

struct Onboarding: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.presentationMode) var presentation
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var showingAlert: Bool = false
    
    
    var body: some View {
        NavigationStack {
            
            VStack {
                    HStack {
                        Image(.littleLemonLogo)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                            .padding(0)
                    }
               
                    personalInformationDetails
                    
                Spacer()
                    Button("Next...") {
                        if  dataIsEntered() {
                            saveData()
                            isLoggedIn = true
                        } else {
                            self.showingAlert = true
                        }
                        
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Important message"), message: Text("Please fill out all the fields"), dismissButton: .default(Text("Got it!")))
                    }
                    .padding(10)
                    .padding(.horizontal, 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.theme.green)
                            .stroke(Color.theme.green, lineWidth: 1 )
                    )
                    .foregroundColor(.theme.silver)
                    .cornerRadius(10)
                    .padding(.bottom, 40)
            }
        }
        .onAppear {
            if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                isLoggedIn = true
            }
        }
        .navigationDestination(isPresented: $isLoggedIn) {
                EmailNotificationSignup()
                           .environment(\.managedObjectContext, viewContext)
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func dataIsEntered() -> Bool {
       return !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !phoneNumber.isEmpty
    }
    
    private func saveData() {
        UserDefaults.standard.set(firstName, forKey: kFirstName)
        UserDefaults.standard.set(lastName, forKey: kLastName)
        UserDefaults.standard.set(email, forKey: kEmail)
        UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)
        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
    }
    
}


extension Onboarding {
    private var personalInformationDetails: some View {
        VStack(alignment: .leading) {
            Text("First Name")
                .font(.caption)
                .padding(.top, 10)
                .padding(.bottom, 0)
            TextField(firstName, text: $firstName)
                .font(.headline)
                .padding(6)
            Text("Last Name")
                .font(.caption)
                .padding(.top, 10)
                .padding(.bottom, 0)
            TextField(lastName, text: $lastName)
                .font(.headline)
                .padding(6)
            Text("Email")
                .font(.caption)
                .padding(.top, 10)
                .padding(.bottom, 0)
            TextField(email, text: $email)
                .font(.headline)
                .padding(6)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
//                .foregroundColor(email.isValidEmail ? .theme.black : .red)
            Text("Phone number")
                .font(.caption)
                .padding(.top, 10)
                .padding(.bottom, 0)
            TextField(phoneNumber, text: $phoneNumber)
                .keyboardType(.numberPad)
                .onReceive(Just(phoneNumber)) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        self.phoneNumber = filtered
                    }
                }
                .font(.headline)
                .padding(6)
        }
        .textFieldStyle(.roundedBorder)
        .padding()
    }
}

extension String {
    
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        ).evaluate(with: self)
//        print("Here")
        
//      return  NSPredicate(format: "SELF MATCHES %@", "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
//
//        ).evaluate(with: self)
//        
    }
}


#Preview {
    NavigationStack {
        Onboarding()
    }
}
