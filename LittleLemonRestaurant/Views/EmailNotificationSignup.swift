//
//  EmailNotificationSignup.swift
//  LittleLemonRestaurant
//
//  Created by tony on 9/5/2024.
//

import SwiftUI

struct EmailNotificationSignup: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.presentationMode) var presentation
    
    @State private var continuePressed: Bool = false
    
    @State private var orderStatuses: Bool = false
    @State private var phoneNumberChanges: Bool = false
    @State private var specialOffers: Bool = false
    @State private var newsletters: Bool = false
    
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                
                HStack {
                    Image(.littleLemonLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(0)
                }
                
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Signup for Email notifications (optional)")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 15)
                    
                    Toggle(isOn: $orderStatuses) {
                        Text("Order statuses")
                    }.toggleStyle(iOSCheckboxToggleStyle())
                    
                    Toggle(isOn: $phoneNumberChanges) {
                        Text("Phone number changes")
                    }.toggleStyle(iOSCheckboxToggleStyle())
                    
                    Toggle(isOn: $specialOffers) {
                        Text("Special offers")
                    }.toggleStyle(iOSCheckboxToggleStyle())
                    
                    Toggle(isOn: $newsletters) {
                        Text("Newsletters")
                    }.toggleStyle(iOSCheckboxToggleStyle())
                    
                    Text("")
                    
                    Spacer()
                    
                    
                }
                Button("...and now for the menu") {
                    saveData()
                    continuePressed = true
                }
                .padding(10)
                .padding(.horizontal, 30)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.theme.green)
                        .stroke(Color.theme.green, lineWidth: 1 )
                )
                .foregroundColor(.theme.silver)
                .cornerRadius(10)
                .padding(.bottom, 40)
                .navigationDestination(isPresented: $continuePressed) {
                    Home()
                        .environment(\.managedObjectContext, viewContext)
                }
                
            }
            .padding(.horizontal, 10)
//            .navigationBarBackButtonHidden(true)
        }
    }
    
    private func saveData() {
        
        UserDefaults.standard.set(orderStatuses, forKey: kOrderStatuses)
        UserDefaults.standard.set(phoneNumberChanges, forKey: kPhoneNumberChanges)
        UserDefaults.standard.set(specialOffers, forKey: kSpecialOffers)
        UserDefaults.standard.set(newsletters, forKey: kNewsletters)
        
    }
}

    
    #Preview {
        EmailNotificationSignup()
    }
