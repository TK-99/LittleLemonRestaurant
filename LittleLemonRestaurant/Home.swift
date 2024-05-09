//
//  Home.swift
//  LittleLemonRestaurant
//
//  Created by tony on 5/5/2024.
//

import SwiftUI

struct Home: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        
        
        TabView {
           
            Menu()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
                .environment(\.managedObjectContext, viewContext)
              
                           
             UserProfile()
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        
        .toolbar(content: {
            HStack {
                Spacer()
                Image(.littleLemonLogo)
                    .resizable()
                    .frame(height: 40)
                    .padding(0)
                Image(.profileImagePlaceholder)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(0)
            }
        })
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    NavigationStack {
        Home()
    }
   
}
