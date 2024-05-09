//
//  UserProfile.swift
//  LittleLemonRestaurant
//
//  Created by tony on 5/5/2024.
//

import SwiftUI

struct UserProfile: View {
    
//    @Environment(\.managedObjectContext) private var viewContext
//    @Environment(\.presentationMode) var presentation
    @State private var showingAlert: Bool = false
    
    private var firstName: String = ""
    private var lastName: String = ""
    private var email: String = ""
    private var phoneNumber = ""
    private var orderStatuses: Bool = false
    private var phoneNumberChanges: Bool = false
    private var specialOffers: Bool = false
    private var newsletters: Bool = false
    
    
    @State private var newFirstName: String = ""
    @State private var newLastName: String = ""
    @State private var newEmail: String = ""
    @State private var newPhoneNumber: String = ""
    @State private var newOrderStatuses: Bool = false
    @State private var newPhoneNumberChanges: Bool = false
    @State private var newSpecialOffers: Bool = false
    @State private var newNewsletters: Bool = false
    
    @State private var logoutButtonPressed: Bool = false

  
    
//    init() {
//        loadData()
//    }
    
    init() {
        print("init")
        firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
        lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
        email = UserDefaults.standard.string(forKey: kEmail) ?? ""
        phoneNumber = UserDefaults.standard.string(forKey: kPhoneNumber) ?? ""
        orderStatuses = UserDefaults.standard.bool(forKey: kOrderStatuses)
        phoneNumberChanges = UserDefaults.standard.bool(forKey: kPhoneNumberChanges)
        specialOffers = UserDefaults.standard.bool(forKey: kSpecialOffers)
        newsletters = UserDefaults.standard.bool(forKey: kNewsletters)
    }
    
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                personalInformationHeader
                
                personalInformationDetails
                
                emailNotificationSection
                
                actionButtonsSection
                
            }
            .onAppear {
                setUpDataFields()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func setUpDataFields() {
        newFirstName = self.firstName
        newLastName = self.lastName
        newEmail = self.email
        newPhoneNumber = self.phoneNumber
        newOrderStatuses = self.orderStatuses
        newPhoneNumberChanges = self.phoneNumberChanges
        newSpecialOffers = self.specialOffers
        newNewsletters = self.newsletters
    }
    
//    private mutating func reloadData() {
//        self.firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
//        self.lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
//        self.email = UserDefaults.standard.string(forKey: kEmail) ?? ""
//        self.phoneNumber = UserDefaults.standard.string(forKey: kPhoneNumber) ?? ""
//        self.orderStatuses = UserDefaults.standard.bool(forKey: kOrderStatuses)
//        self.phoneNumberChanges = UserDefaults.standard.bool(forKey: kPhoneNumberChanges)
//        self.specialOffers = UserDefaults.standard.bool(forKey: kSpecialOffers)
//        self.newsletters = UserDefaults.standard.bool(forKey: kNewsletters)
//    }
    
    private func saveData() {
        UserDefaults.standard.set(newFirstName, forKey: kFirstName)
        UserDefaults.standard.set(newLastName, forKey: kLastName)
        UserDefaults.standard.set(newEmail, forKey: kEmail)
        UserDefaults.standard.set(newPhoneNumber, forKey: kPhoneNumber)
        UserDefaults.standard.set(newOrderStatuses, forKey: kOrderStatuses)
        UserDefaults.standard.set(newPhoneNumberChanges, forKey: kPhoneNumberChanges)
        UserDefaults.standard.set(newSpecialOffers, forKey: kSpecialOffers)
        UserDefaults.standard.set(newNewsletters, forKey: kNewsletters)
        
//        firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
//        lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
//        email = UserDefaults.standard.string(forKey: kEmail) ?? ""
//        phoneNumber = UserDefaults.standard.string(forKey: kPhoneNumber) ?? ""
//        orderStatuses = UserDefaults.standard.bool(forKey: kOrderStatuses)
//        phoneNumberChanges = UserDefaults.standard.bool(forKey: kPhoneNumberChanges)
//        specialOffers = UserDefaults.standard.bool(forKey: kSpecialOffers)
//        newsletters = UserDefaults.standard.bool(forKey: kNewsletters)
    }
}

#Preview {
    NavigationStack {
        UserProfile()
    }
    
}

extension UserProfile {
    private var personalInformationHeader: some View {
        VStack(alignment: .leading) {
            Text("Personal Information")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.vertical, 10)
            
            Text("Avatar")
                .font(.caption)
            
            HStack(spacing: 20) {
                Image(.profileImagePlaceholder)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding(0)
                
                Spacer()
                
                Button("Change") {
                    self.showingAlert = true
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Change avatar not activated yet"), message: Text(""), dismissButton: .default(Text("Ok")))
                }
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.theme.green)
                        .stroke(Color.theme.green, lineWidth: 1 )
                )
                .foregroundColor(.theme.silver)
                .cornerRadius(10)
                
                Button("Remove") {
                    self.showingAlert = true
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Remove avatar not activated yet"), message: Text(""), dismissButton: .default(Text("Ok")))
                }
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.theme.silver)
                        .stroke(Color.theme.silver, lineWidth: 1 )
                )
                .foregroundColor(.theme.green)
                .cornerRadius(10)
                
                Spacer()
            }
            .font(.subheadline)
        }
        .onAppear {
//            self.firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
        }
    }
    
    private var personalInformationDetails: some View {
        VStack(alignment: .leading) {
            Text("First Name")
                .font(.caption2)
                .padding(.top, 10)
                .padding(.bottom, 0)
            TextField(firstName, text: $newFirstName)
                .font(.headline)
                .padding(6)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.theme.silver, lineWidth: 1 )
                )
                .padding(0)
            
            Text("Last Name")
                .font(.caption2)
                .padding(.top, 10)
                .padding(.bottom, 0)
            TextField(lastName, text: $newLastName)
                .font(.headline)
                .padding(6)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.theme.silver, lineWidth: 1 )
                )
                .padding(0)
            
            Text("Email")
                .font(.caption2)
                .padding(.top, 10)
                .padding(.bottom, 0)
            TextField(email, text: $newEmail)
                .font(.headline)
                .padding(6)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.theme.silver, lineWidth: 1 )
                )
                .padding(0)
            
            Text("Phone number")
                .font(.caption2)
                .padding(.top, 10)
                .padding(.bottom, 0)
            TextField(phoneNumber, text: $newPhoneNumber)
                .font(.headline)
                .padding(6)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.theme.silver, lineWidth: 1 )
                )
                .padding(0)
        }
    }
    
    private var  emailNotificationSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text("Email notifications")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.top, 15)
            
            Toggle(isOn: $newOrderStatuses) {
                Text("Order statuses")
            }.toggleStyle(iOSCheckboxToggleStyle())
            
            Toggle(isOn: $newPhoneNumberChanges) {
                Text("Phone Number changes")
            }.toggleStyle(iOSCheckboxToggleStyle())
            
            Toggle(isOn: $newSpecialOffers) {
                Text("Special offers")
            }.toggleStyle(iOSCheckboxToggleStyle())
            
            Toggle(isOn: $newNewsletters) {
                Text("Newsletters")
            }.toggleStyle(iOSCheckboxToggleStyle())
            
            Text("")
            
        }
    }
    
    private var actionButtonsSection: some View {
        ZStack {
            VStack(alignment: .center, spacing: 10) {
                HStack(spacing: 30) {
                    Button("Discard changes") {
                        setUpDataFields()
                    }
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.theme.green)
                            .stroke(Color.theme.green, lineWidth: 1 )
                    )
                    .foregroundColor(.theme.silver)
                    .cornerRadius(10)
                                        
                    Button("Save changes") {
                        saveData()
//                        setUpDataFields()
                    }
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.theme.silver)
                            .stroke(Color.theme.green, lineWidth: 1 )
                    )
                    .foregroundColor(.theme.green)
                    .cornerRadius(10)
                    
                }
                .frame(maxWidth: .infinity)
                
                Button(action: {
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    logoutButtonPressed = true
                    
//                    self.presentation.wrappedValue.dismiss()
                }, label: {
                    Text("Log Out")
                        .fontWeight(.semibold)
                        .frame(maxWidth: 300)
                        .padding(.vertical, 10)
                        .foregroundColor(.theme.green)
                        .background(Color.theme.yellow)
                        .cornerRadius(10)
                })
            }
            .navigationDestination(isPresented: $logoutButtonPressed) {
                Welcome()
                    .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            }
            .font(.footnote)
        }
    }
    
}






