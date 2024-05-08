//
//  DishDetails.swift
//  LittleLemonRestaurant
//
//  Created by tony on 7/5/2024.
//

import SwiftUI

struct DishDetails: View {
    
    let dish: Dish
    
    
    var body: some View {
        
        
        VStack {
            Rectangle()
                .frame(width: 400, height: 150)
            //                        let url = URL(string: menuItem.image)!
            //                        AsyncImage(url: url) { image in
            //                            image.resizable()
            //                        } placeholder: {
            //                            ProgressView()
            //                        }
            //                        .frame(width: 100, height: 100)
            VStack {
                Text(dish.title ?? "")
                Text(dish.itemDescription ?? "")
                Text(dish.price ?? "")
            }
            
        }
        Spacer()
        
    }
}

//#Preview {
//    
//}
