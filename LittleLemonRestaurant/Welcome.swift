//
//  Welcome.swift
//  LittleLemonRestaurant
//
//  Created by tony on 9/5/2024.
//
let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kPhoneNumber = "phone number key"
let kIsLoggedIn = "is loggedin key"

let kOrderStatuses = "order statuses key"
let kPhoneNumberChanges = "phone number changes key"
let kSpecialOffers = "special offers key"
let kNewsletters = "newsletters key"

let kDataDownloaded = "dataloaded key"



import SwiftUI

struct Welcome: View {
    
    @Environment(\.managedObjectContext) private var viewContext
        
    @State private var continuePressed: Bool = false
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.silver.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Image(.littleLemonLogoLarge)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 200)
                    .padding(.top, 150)
                
                
                Text("Welcome to our new Menu App")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(30)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.theme.green)
                
                Spacer()
                
                Button("Click to continue...") {
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
                    if !isLoggedIn {
                        Onboarding()
                            .environment(\.managedObjectContext, viewContext)
                    } else {
                        Home()
                            .environment(\.managedObjectContext, viewContext)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
//            print("appear")
            if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                isLoggedIn = true
                continuePressed = true
            } else {
                isLoggedIn = false
                continuePressed = false
            }
        }
    }
}

#Preview {
    Welcome()
}
