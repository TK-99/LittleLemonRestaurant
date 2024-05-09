//
//  FontList.swift
//  LittleLemonRestaurant
//
//  Created by tony on 8/5/2024.
//

import SwiftUI

struct FontList: View {
        var body: some View {
            ScrollView{
                ForEach(UIFont.familyNames.sorted(), id: \.self) { family in
                    let names = UIFont.fontNames(forFamilyName: family)
                    ForEach(names, id: \.self) { name in
                        Text(name).font(Font.custom(name, size: 20))
                    }
                }
            }
        }
}

#Preview {
    FontList()
}
