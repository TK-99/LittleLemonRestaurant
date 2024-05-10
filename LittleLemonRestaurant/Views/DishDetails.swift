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
//            Rectangle()
//                .frame(width: 400, height: 150)
                let url = URL(string: dish.image ?? "")
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/ , maxHeight: 200)
            VStack {
                Text(dish.title ?? "")
                    .font(.title)
                    .fontWeight(.semibold)
                    
                Text(dish.itemDescription ?? "")
                    .font(.callout)
                    .padding()
                Text("$\(dish.price ?? "0.00")")
                    .font(.headline)
            }
            
        }
        Spacer()
        
    }
}

//#Preview {
//    
//}
