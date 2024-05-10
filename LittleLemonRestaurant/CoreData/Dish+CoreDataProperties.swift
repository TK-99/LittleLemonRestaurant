//
//  Dish+CoreDataProperties.swift
//  LittleLemonRestaurant
//
//  Created by tony on 5/5/2024.
//
//

import Foundation
import CoreData

@objc(Dish)
public class Dish: NSManagedObject {

}

extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var title: String?
    @NSManaged public var image: String?
    @NSManaged public var price: String?
    @NSManaged public var itemDescription: String?
    @NSManaged public var category: String?

}

extension Dish : Identifiable {
    static func createDishesFrom(menuItems:[MenuItem],
                                 _ context:NSManagedObjectContext) {
        for menuItem in menuItems {
            let oneDish = Dish(context: context)
            oneDish.title = menuItem.title
            oneDish.price = menuItem.price
            oneDish.itemDescription = menuItem.description
            oneDish.image = menuItem.image
            oneDish.category = menuItem.category
        }
    }
    
    private static func request() -> NSFetchRequest<NSFetchRequestResult> {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: Self.self))
        request.returnsDistinctResults = true
        request.returnsObjectsAsFaults = true
        return request
    }
    
    static func with(title: String,
//                     lastName:String,
                     _ context:NSManagedObjectContext) -> Dish? {
        let request = Dish.request()
        
        let predicate = NSPredicate(format: "title", title)
        request.predicate = predicate
                
        do {
            guard let results = try context.fetch(request) as? [Dish],
                  results.count > 0
            else { return nil }
            return results.first
        } catch (let error){
            print(error.localizedDescription)
            return nil
        }
    }
    
}


