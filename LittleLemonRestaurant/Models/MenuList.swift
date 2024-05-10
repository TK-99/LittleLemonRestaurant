//
//  MenuList.swift
//  LittleLemonRestaurant
//
//  Created by tony on 5/5/2024.
//

import Foundation
import CoreData

struct MenuList: Codable {
    let menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
    
    static func getMenuData(viewContext: NSManagedObjectContext) {
        print("clearing data")
        PersistenceController.shared.clear()
        
        let urlString =  "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let fullMenu = try decoder.decode(MenuList.self, from: data)

                    for menuItem in fullMenu.menu {
                        let oneDish = Dish(context: viewContext)
                        oneDish.title = menuItem.title
                        oneDish.price = menuItem.price
                        oneDish.itemDescription = menuItem.description
                        oneDish.image = menuItem.image
                        oneDish.category = menuItem.category
                    }
                    try? viewContext.save()

                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }
        }
        
        task.resume()
    }

}
