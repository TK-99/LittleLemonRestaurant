//
//  LittleLemonRestaurantApp.swift
//  LittleLemonRestaurant
//
//  Created by tony on 1/5/2024.
//

import SwiftUI

@main
struct LittleLemonRestaurantApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                Welcome()
                     .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}



