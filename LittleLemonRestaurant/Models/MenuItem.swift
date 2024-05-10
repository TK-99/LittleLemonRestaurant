//
//  MenuItems.swift
//  LittleLemonRestaurant
//
//  Created by tony on 5/5/2024.
//

import Foundation

struct MenuItem: Codable, Identifiable {
    let id: Int
    let image: String
    let description: String
    let price: String
    let title: String
    let category: String
}
